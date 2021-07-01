//
//  ViewController.swift
//  OfferBoard
//
//  Created by Рафаил Фаталиев on 24.05.2021.
//

import UIKit

class AuthViewController: UIViewController {
    
    let authView = AuthView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view = authView
        addTargets()
        navigationController?.navigationBar.isHidden = true
        
    }
    
    func addTargets() {
        authView.singInButton.addTarget(self, action: #selector(signIn), for: .touchUpInside)
        authView.singUpButton.addTarget(self, action: #selector(showRegVC), for: .touchUpInside)
        
        
        
    }
    
    @objc func showRegVC() {
        
        let vc = RegViewController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
        
        
    }
    
    @objc func signIn() {
        
        guard let login = authView.loginTF.text else { return }
        guard let password = authView.passwordTF.text else { return }
        
        AlomoFireManager.signIn(login: login,
                                password: password) { result in
            switch result {
            case .success((let token, let id)):
                AppDelegate.userDefaults.setValue(token, forKey: AppDelegate.tokenKey)
                AppDelegate.userDefaults.setValue(id, forKey: AppDelegate.idKey)
                
                AlomoFireManager.getProfile { result in
                    switch result {
                    case .success(let profile):
                        let profileVC = ProfileViewController(profile: profile)
                        profileVC.modalPresentationStyle = .currentContext
                        self.present(profileVC, animated: true, completion: nil)
                  
                    case .failure(let error):
                        print(error.localizedDescription)
                        
                        
                    }
                }
                
                
            case .failure(_):
                print("NOT OK")
            }
            
        }
    }
}
