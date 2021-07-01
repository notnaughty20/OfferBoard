//
//  AlamoFire.swift
//  Neworking
//
//  Created by Рафаил Фаталиев on 21.05.2021.
//

import Foundation
import Alamofire
import SwiftyJSON


class AlomoFireManager {
    
    static func authHeader() -> HTTPHeader? {
        
        guard let token = AppDelegate.userToken else { return nil }
        print(token)
        
        let tokenString = "\(token):"
        let tokenData = tokenString.data(using: .utf8, allowLossyConversion: false)
        let base64Token = tokenData!.base64EncodedString()
        
        let header: HTTPHeader = HTTPHeader(name: "Authorization", value: "Basic \(base64Token)")
        
        return header
    }
    
    
    
    
    static func addItem(item: RFProducts, photos: [UIImage], completion: @escaping (Result<Any,Error>) -> Void) {
        
        let url = URLManager.createUrl(method: .addItem)
        
        var photosData = [Data]()
        
        for photo in photos {
            photosData.append(photo.jpegData(compressionQuality: 0.6)!)
        }
        
        let params: Parameters = ["name": item.name,
                                  "price": item.price,
                                  "info": item.descript,
                                  "material": "",
                                  "size": "",
                                  "status": "",
                                  "address": item.address,
                                  "category_id": 64]
        
        AF.upload(multipartFormData: { multipartFormData in
            
            for (index, image) in photosData.enumerated() {
                multipartFormData.append(image, withName: "upfile[]", fileName: "iosFile\(index)", mimeType: "image/jpg")
            }
            
            for (key, parameter) in params {
                multipartFormData.append(String(describing: parameter).data(using: .utf8)!, withName: key)
            }
            
        }, to: url, headers: [self.authHeader()!]).responseJSON { response in
            
            switch response.result {
            
            case .success(let json):
                print(json)
                completion(.success(json))
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
        
    }
    
    static func getItem(id: String, completion: @escaping(Result<RFProducts, Error>) -> Void) {
        
        let url = URLManager.createItemUrl(id: id)
        
        AF.request(url).validate().responseJSON { response in
            
            switch response.result {
            
            case .success(let json):
                let json = JSON(json)
                let item = ParsingManager.parsingItem(json: json)
                completion(.success(item))
            case .failure(let error):
                completion(.failure(error))
            }
            
        }
        
        
    }
    
    static func downloadImage(url: String, completion: @escaping (Result<UIImage, Error>) -> Void) {
        
        AF.download(url).validate().responseData { response in
            
            switch response.result {
            
            case .success(let imageData):
                let image = UIImage(data: imageData)
                completion(.success(image!))
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    static func getItems(page: Int, completion: @escaping (Result<([RFProducts], Int), Error>) -> Void) {
        
        let params: Parameters = ["page": page]
        let url = URLManager.createUrl(method: .items)
        
        AF.request(url, parameters: params).validate().responseJSON { response in
            switch response.result {
            
            case .success(let json):
                let json = JSON(json)
                print(json)
                
                let pageCount = ParsingManager.parsingPageCount(json: json)
                let items: [RFProducts] = ParsingManager.parsingItemsForCatalog(json: json)
                completion(.success((items, pageCount)))
                
            case .failure(let error):
                print(error.localizedDescription)
                completion(.failure(error))
            }
        }
        
    }
    
    static func getMyItems(completion: @escaping (Result<[RFProducts], Error>) -> Void) {
        
        let url = URLManager.createUrl(method: .myProducts)
        
        AF.request(url, method: .post,  headers: [authHeader()!]).validate().responseJSON { response in
            
            switch response.result {
            
            case .success(let json):
                let json = JSON(json)
                print(json)
//                completion(.success(profile))
            case .failure(let error):
                completion(.failure(error))
            }
            
        }
        
    }
    
    static func getProfile(completion: @escaping (Result<RFProfile, Error>) -> Void) {
        
        let url = URLManager.createUrl(method: .profile)
        
        AF.request(url, method: .post, headers: [authHeader()!]).validate().responseJSON { response in
            
            switch response.result {
            
            case .success(let json):
                let json = JSON(json)
                let profile = ParsingManager.parsingProfile(json: json)
                completion(.success(profile))
            case .failure(let error):
                completion(.failure(error))
            }
            
        }
        
    }
    
    static func signIn(login: String,
                password: String,
                completion: @escaping(Result<(String, Int), Error>) -> Void) {
        
        let url = URLManager.createUrl(method: .auth)
        
        let lpString = "\(login):\(password)"
        let lpData = lpString.data(using: .utf8, allowLossyConversion: false)
        let base64 = lpData!.base64EncodedString()
        let headers: HTTPHeaders = ["Authorization": "Basic \(base64)"]
        
        AF.request(url, method: .post, headers: headers).validate().responseJSON { response in
            
            switch response.result {
            
            case .success(let json):
                let json = JSON(json)
                print(json)
                let auth = ParsingManager.parsingAuth(json: json)
                completion(.success(auth))
            case .failure(let error):
                print(error.localizedDescription)
                completion(.failure(error))
            }
        }
    }
    
    static func signUp(login: String,
                password: String,
                name: String,
                surname: String,
                phone: String,
                completion: @escaping(Result<Any, Error>) -> Void) {
        
        guard phone.count == 10 else {
            print("Количество цифр должно быть 10")
            return
        }
        
        guard Int(phone) != nil else {
            print("Телефон инвалид")
            return
        }
        
        let url = URLManager.createUrl(method: .reg)
        
        let params = ["username": login,
                      "password": password,
                      "first_name": name,
                      "surname": surname,
                      "tel": phone]
        
        AF.request(url, method: .post, parameters: params).validate().responseJSON { response in
            switch response.result {
            case .success(let data):
                completion(.success(data))
                print(data)
            case .failure(let error):
                completion(.failure(error))
                print(error.localizedDescription)
            }
        }
    }
    
    

}
