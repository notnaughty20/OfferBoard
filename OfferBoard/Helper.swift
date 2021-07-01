//
//  Helper.swift
//  OfferBoard
//
//  Created by Рафаил Фаталиев on 24.05.2021.
//

import UIKit

class Helper {
    
    static func tamicOff(views: [UIView]) {
        for view in views {
            view.translatesAutoresizingMaskIntoConstraints = false
        }
    }
}
