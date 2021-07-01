//
//  ProfileViewController.swift
//  OfferBoard
//
//  Created by Рафаил Фаталиев on 31.05.2021.
//

import UIKit

class ProfileViewController: UIViewController {
    
    var profileView: ProfileView
    var profile: RFProfile
    
    init(profile: RFProfile) {
        self.profile = profile
        self.profileView = ProfileView(profile: profile)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileView.tableView.delegate = self
        profileView.tableView.dataSource = self
        
       
        navigationController?.navigationBar.isHidden = true
        self.view = profileView
        AlomoFireManager.getProfile { result in
            
        }
        
        addTargets()
        
      

        
    }
    
    func addTargets() {
        
        profileView.logoutButton.addTarget(self, action: #selector(logOut), for: .touchUpInside)
        profileView.addProductsButton.addTarget(self, action: #selector(addItem), for: .touchUpInside)
    }
    
    @objc func addItem() {
        
        let vc = NewItemViewController()
        self.present(vc, animated: true, completion: nil)
    }
    
    @objc func logOut() {
        
        AppDelegate.userDefaults.setValue(nil, forKey: AppDelegate.tokenKey)
        AppDelegate.userDefaults.setValue(nil, forKey: AppDelegate.idKey)
        
        let vc = AuthViewController()
        vc.modalPresentationStyle = .currentContext
        
        self.present(vc, animated: true, completion: nil)
        
        

        
    }
    

    

}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: MyItemCell.reuseId, for: indexPath) as! MyItemCell
        
        
        
        
        return cell
    }
    
    
    
}
