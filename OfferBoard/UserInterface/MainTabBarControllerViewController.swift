//
//  MainTabBarControllerViewController.swift
//  OfferBoard
//
//  Created by Рафаил Фаталиев on 31.05.2021.
//

import UIKit

class MainTabBarControllerViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       let catalogVC = CatalogViewController()
        
        
        let imageWeight = UIImage.SymbolConfiguration(weight: .light)
        let catalogImage = UIImage(systemName: "giftcard", withConfiguration: imageWeight)
        let profileImage = UIImage(systemName: "person.circle.fill", withConfiguration: imageWeight)
        
        let firstVC = generateNavVC(vc: catalogVC, title: "Catalog", image: catalogImage!)
        var secondVC = UIViewController()
        
        if let token: String = AppDelegate.userDefaults.value(forKey: AppDelegate.tokenKey) as? String {
            
            AlomoFireManager.getProfile { result in
                switch result {
                
                case .success(let profile):
                    let profileVC = ProfileViewController(profile: profile)
                    secondVC = self.generateNavVC(vc: profileVC, title: "Profile", image: profileImage!)
                    self.viewControllers?.append(secondVC)
                case .failure(let error):
                    print(error.localizedDescription)
                    
                }
            }
            
 
        } else {
            let authVC = AuthViewController()
            secondVC = generateNavVC(vc: authVC, title: "Profile", image: profileImage!)
            
        }

        self.viewControllers = [firstVC,secondVC]
        
    }


    private func generateNavVC(vc: UIViewController, title: String, image: UIImage) -> UIViewController {
        
        let navVC = UINavigationController(rootViewController: vc)
        navVC.tabBarItem.title = title
        navVC.tabBarItem.image = image
        return navVC
    }
}
