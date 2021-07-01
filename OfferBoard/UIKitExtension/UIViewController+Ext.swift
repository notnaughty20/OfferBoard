//
//  UIViewController+Ext.swift
//  OfferBoard
//
//  Created by Рафаил Фаталиев on 22.06.2021.
//

import UIKit

extension UIViewController {
    
    func showAlert(title: String?, text: String?, buttons: [UIAlertAction]) {
        
        let alert = UIAlertController(title: title, message: text, preferredStyle: .alert)
        
        for button in buttons {
            alert.addAction(button)
        }
        
        self.present(alert, animated: true, completion: nil)
        
    }
}
