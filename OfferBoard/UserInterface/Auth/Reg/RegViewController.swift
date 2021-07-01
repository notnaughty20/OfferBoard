//
//  RegViewController.swift
//  OfferBoard
//
//  Created by Влад Мади on 24.05.2021.
//

import UIKit

class RegViewController: UIViewController {
    
    let regView = RegView()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = regView
        addTargets()
        
    }
    
    func addTargets() {
        regView.signInButtonIfHave.addTarget(self, action: #selector(dismissSelf), for: .touchUpInside)
        regView.regButton.addTarget(self, action: #selector(registration), for: .touchUpInside)
    }
    
    @objc func dismissSelf() {
        self.dismiss(animated: true, completion: nil)
    }

    @objc func registration() {
        AlomoFireManager.signUp(login: regView.eMail.text!,
                                password: regView.passwordTFReg.text!,
                                name: regView.name.text!,
                                surname: regView.surName.text!,
                                phone: regView.phoneNumber.text!) { result in
            
            switch result {
            
            case .success(_):
                print("OK")
                let alert = UIAlertController(title: "Ура", message: "Регистрация прошла успешно. Проверьте свою почту.", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default) { _ in
                    self.dismiss(animated: true, completion: nil)
                }
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
            case .failure(_):
                print("NOT OK")
            }
            
        }
                               
    
}
}
