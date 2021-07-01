//
//  RFItem.swift
//  OfferBoard
//
//  Created by Рафаил Фаталиев on 06.06.2021.
//

import Foundation

struct RFProducts {
    
    var id: String
    var name: String
    var price: Int
    var descript: String
    var imgUrl: String
    var gallery: [String] = [String]()
    var address = ""
    var seller = RFProfile(email: "",
                           firstName: "",
                           surname: "",
                           phone: "",
                           imageUrl: "")
}
