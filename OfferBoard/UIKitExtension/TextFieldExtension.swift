//
//  TextFieldExtension.swift
//  OfferBoard
//
//  Created by Рафаил Фаталиев on 24.05.2021.
//

import UIKit

extension UITextField {
    
    convenience init(placeholder: String) {
        
        self.init()
        self.placeholder = placeholder
        self.font = RFFonts.regularTextFont
        self.borderStyle = .none
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 3))
        self.leftViewMode = .always
        self.backgroundColor = .white
        
    }
        
}
