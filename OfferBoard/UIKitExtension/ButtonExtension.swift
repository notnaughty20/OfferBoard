//
//  ButtonExtension.swift
//  OfferBoard
//
//  Created by Рафаил Фаталиев on 24.05.2021.
//

import UIKit

extension UIButton {
    
    convenience init(title: String,
                     backgroundColor: UIColor,
                     textColor: UIColor,
                     font: UIFont?,
                     cornerRadius: CGFloat) {
        self.init(type: .system)
        self.setTitle(title, for: .normal)
        self.setTitleColor(textColor, for: .normal)
        self.titleLabel?.font = font
        self.layer.cornerRadius = cornerRadius
        self.backgroundColor = backgroundColor
        
    }
}
