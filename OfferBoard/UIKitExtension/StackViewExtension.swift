//
//  StackViewExtension.swift
//  OfferBoard
//
//  Created by Рафаил Фаталиев on 24.05.2021.
//

import UIKit

extension UIStackView {
    
    convenience init(arrangedSubviews: [UIView],
                     axis: NSLayoutConstraint.Axis,
                     spacing: CGFloat) {
        
        self.init(arrangedSubviews: arrangedSubviews)
        self.axis = axis
        self.spacing = spacing
        
    }
}

