//
//  URLMaganer.swift
//  Neworking
//
//  Created by Рафаил Фаталиев on 17.05.2021.
//

import Foundation

class URLManager {
    
   static let tunnel = "https://"
  static let apiUrl = "maditest.site/v1/"
    
    
   static func createUrl(method: ApiMethod) -> String {
        
    
        return tunnel + apiUrl + method.rawValue
        
    
    }
    
    static func createItemUrl(id: String) -> String {
        
        let url = createUrl(method: .item) + id
        
        return url
   
}
    


}
