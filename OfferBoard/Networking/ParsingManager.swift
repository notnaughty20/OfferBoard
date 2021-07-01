//
//  ParsingManager.swift
//  Neworking
//
//  Created by Рафаил Фаталиев on 17.05.2021.
//

import Foundation
import SwiftyJSON

class ParsingManager {
    
    static func parsingAuth(json: JSON) -> (String, Int) {
        var result = ("", 0)
        
        result.0 = json["access_token"].stringValue
        result.1 = json["id"].intValue
        
        return result
        
        
    }
    
    static func parsingProfile(json: JSON) -> RFProfile {
        
        let name = json["first_name"].stringValue
        let email = json["username"].stringValue
        let surname = json["surname"].stringValue
        let phone = json["tel"].stringValue
        let imageUrl = json["image"].stringValue
        
        let profile = RFProfile(email: email, firstName: name, surname: surname, phone: phone, imageUrl: imageUrl)
        
        return profile

        
    }
    
    static func parsingPageCount(json: JSON) -> Int {
        
        let json = json["_meta"]
        
        let count = json["pageCount"].intValue
        return count
        
    }
    
    static func parsingItemsForCatalog(json: JSON) -> [RFProducts] {
        
        let itemsJson = json["items"].arrayValue
        
        var items = [RFProducts]()
        
        for item in itemsJson {
            
            let id = item["id"].stringValue
            let title = item["name"].stringValue
            let price = item["price"].intValue
            let imgUrl = item["img"].stringValue
            
            let rfItem = RFProducts(id: id, name: title, price: price, descript: "", imgUrl: imgUrl)
            
            items.append(rfItem)
            
        }
        
        return items
        
    }
        
   static func parsingItem(json: JSON) -> RFProducts {
    
    let id = json["id"].stringValue
    let name = json["name"].stringValue
    let price = json["price"].intValue
    let imgUrl = json["gallery"].arrayValue[0].stringValue
    let desctription = json["info"].stringValue
        
        var item = RFProducts(id: id,
                              name: name,
                              price: price,
                              descript: desctription,
                              imgUrl: imgUrl)
    
    for img in json["gallery"].arrayValue {
        item.gallery.append(img.stringValue)
        
    }
    
    item.address = json["address"].stringValue
    
    
    let email = json["user"]["username"].stringValue
    let firstname = json["user"]["firstname"].stringValue
    let surname = json["user"]["surname"].stringValue
    let avatarUrl = json["user"]["image"].stringValue
    let phone = json["user"]["tel"].stringValue
    let itemsCount = json["user"]["items_count"].intValue

    var user = RFProfile(email: email,
                         firstName: firstname,
                         surname: surname,
                         phone: phone,
                         imageUrl: avatarUrl)
    
    user.itemsCount = itemsCount
    
    item.seller = user
        
        return item
        
    }
    
    

}
