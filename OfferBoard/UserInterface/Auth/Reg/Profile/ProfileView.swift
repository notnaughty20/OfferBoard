//
//  ProfileView.swift
//  OfferBoard
//
//  Created by Рафаил Фаталиев on 01.06.2021.
//

import UIKit

class ProfileView: UIView {
    
    
    
    let logoutButton = UIButton(title: "Выйти", backgroundColor: RFColors.blue, textColor: .white, font: RFFonts.regularTextFont, cornerRadius: 6)
    
    let nameLabel = UILabel(text: "Name", font: RFFonts.regularTextFont)
    let secondNameLabel = UILabel(text: "secondName", font: RFFonts.regularTextFont)
    let phoneLabel = UILabel(text: "Phone", font: RFFonts.regularTextFont)
    let emailLabel = UILabel(text: "Email", font: RFFonts.regularTextFont)
    let productsLabel = UILabel(text: "Products", font: RFFonts.regularTextFont)
    let addProductsButton = UIButton(title: "   Add Products   ", backgroundColor: .blue, textColor: .white, font: RFFonts.regularTextFont, cornerRadius: 6)
    
    var profileImage = UIImageView(image: UIImage(named: "witcher"))
    
    let tableView = UITableView()
    
    var profile: RFProfile
    
    
    
    
    init(profile: RFProfile) {
        self.profile = profile
        super.init(frame: CGRect())
        setupSubviews()
        setupConstraints()
        backgroundColor = .white
        
        
        
    }
    
    func setupSubviews() {
        
        tableView.register(MyItemCell.self, forCellReuseIdentifier: MyItemCell.reuseId)
        tableView.tableFooterView = UIView()
        
        nameLabel.text = "\(profile.firstName)"
        secondNameLabel.text = "\(profile.surname)"
        phoneLabel.text = "+7 \(profile.phone)"
        emailLabel.text = "\(profile.email)"
        
        
        
        
        
        
    }
    
    func setupConstraints() {
        
        
        
        tableView.separatorStyle = .none
        
        
        addSubview(logoutButton)
        Helper.tamicOff(views: [logoutButton])
        addSubview(tableView)
        
        
        addSubview(profileImage)
        profileImage.clipsToBounds = true
        layer.cornerRadius = 15
        profileImage.layer.cornerRadius = 70
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([profileImage.widthAnchor.constraint(equalToConstant: 140),
                                    profileImage.heightAnchor.constraint(equalToConstant: 140),
                                    profileImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
                                    profileImage.topAnchor.constraint(equalTo: topAnchor, constant: 100)])
                                    
        
        NSLayoutConstraint.activate([logoutButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
                                     logoutButton.topAnchor.constraint(equalTo: topAnchor, constant: 40),
                                     logoutButton.widthAnchor.constraint(equalToConstant: 80),
                                     logoutButton.heightAnchor.constraint(equalToConstant: 32)])
        
        
        
        let nameSecondNameStack = UIStackView(arrangedSubviews: [nameLabel, secondNameLabel], axis: .horizontal, spacing: 20)
        addSubview(nameSecondNameStack)
        NSLayoutConstraint.activate([nameSecondNameStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 300),
                                     nameSecondNameStack.topAnchor.constraint(equalTo: topAnchor, constant: 100)])
        
        
        let infoStack = UIStackView(arrangedSubviews: [nameSecondNameStack, phoneLabel, emailLabel], axis: .vertical, spacing: 6)
        addSubview(infoStack)
        infoStack.translatesAutoresizingMaskIntoConstraints = false
        Helper.tamicOff(views: [nameSecondNameStack])
        NSLayoutConstraint.activate([nameSecondNameStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 200),
                                     nameSecondNameStack.topAnchor.constraint(equalTo: topAnchor, constant: 120)])
        
       
        let addProductsStack = UIStackView(arrangedSubviews: [productsLabel, addProductsButton], axis: .horizontal, spacing: 46)
        addSubview(addProductsStack)
        addProductsStack.translatesAutoresizingMaskIntoConstraints = false
        Helper.tamicOff(views: [addProductsStack])
        NSLayoutConstraint.activate([addProductsStack.topAnchor.constraint(equalTo: infoStack.bottomAnchor, constant: 140),
                                     addProductsStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 46),
                                     addProductsStack.centerXAnchor.constraint(equalTo: centerXAnchor),
                                     addProductsButton.widthAnchor.constraint(equalTo: productsLabel.widthAnchor)])
        
        NSLayoutConstraint.activate([tableView.topAnchor.constraint(equalTo: addProductsStack.bottomAnchor, constant: 16),
                                     tableView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -40),
                                     tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
                                     tableView.leadingAnchor.constraint(equalTo: leadingAnchor)])
        Helper.tamicOff(views: [tableView])

        
                                    
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

