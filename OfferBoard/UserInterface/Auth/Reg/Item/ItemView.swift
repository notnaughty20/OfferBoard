//
//  ItemView.swift
//  OfferBoard
//
//  Created by Рафаил Фаталиев on 11.06.2021.
//

import UIKit

class ItemView: UIView {
    
    let item: RFProducts
    var gallery = [UIImage]()
    let backToCatalog = UIButton()
    
    
    var imageView = UIImageView(image:UIImage(named: "image"))
    var miniatures: UICollectionView!
    var imageView2 = UIImageView()
    var imageView3 = UIImageView()
    var imageView4 = UIImageView()
    var sellerImage = UIImageView()
    
    let titleLabel = UILabel(text: "", font: RFFonts.boldTextFont)
    let pricelabel = UILabel(text: "", font: RFFonts.boldTextFont)
    let descriptLabel = UILabel()
    let sellerName = UILabel(text: "", font: RFFonts.boldTextFont)
    let sellerSurName = UILabel(text: "", font: RFFonts.boldTextFont)
    let email = UILabel()
    let phone = UILabel(text: "", font: RFFonts.boldTextFont)
    let callSeller = UIButton(title: "Связаться с продавцом", backgroundColor: RFColors.blue, textColor: .white, font: RFFonts.boldTextFont, cornerRadius: 0)
        
    
    init(item:RFProducts) {
        self.item = item
        super.init(frame: CGRect())
        miniatures = UICollectionView(frame: CGRect(), collectionViewLayout: self.createLayout())
        self.createLayout()
        miniatures.register(MiniatureCell.self, forCellWithReuseIdentifier: MiniatureCell.reuseId)

        setupViews()
        setupConstraints()
        backgroundColor = .white
       
        
     
        
        for url in item.gallery {
            AlomoFireManager.downloadImage(url: url) { result in
                
                switch result {
                
                case .success(let image):
                    self.gallery.append(image)
                case .failure(let error):
                    print(error.localizedDescription)
                }
                
            }
        }
        
        let imgUrl = item.seller.imageUrl
        
        AlomoFireManager.downloadImage(url: imgUrl) { result in
            switch result {
            
            case .success(let sellerImg):
                self.sellerImage.image = sellerImg
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        
        let url1 = item.gallery[0]
        
        AlomoFireManager.downloadImage(url: url1) { result in
            
            switch result {
            
            case .success(let image1):
                self.imageView.image = image1
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
     /*  let url2 = item.gallery[1]
        
        AlamofireManager.downloadImage(url: url2) { result in
            switch result {
            case.success(let image2):
                self.imageView2.image = image2
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
     
    
 
       // let url3 = item.gallery[2]
        
        AlamofireManager.downloadImage(url: url3) { result in
            switch result {
            case.success(let image3):
                self.imageView3.image = image3
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        let url4 = item.gallery[3]
        
        AlamofireManager.downloadImage(url: url4) { result in
            switch result {
            case.success(let image4):
                self.imageView4.image = image4
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        */
        
        isUserInteractionEnabled = true
        imageView.isUserInteractionEnabled = true
    }
  
    
    
    
    
    func setupViews () {
        
        addSubview(imageView)
        addSubview(miniatures)
        addSubview(backToCatalog)
        addSubview(imageView2)
        addSubview(imageView3)
        addSubview(imageView4)
        addSubview(titleLabel)
        addSubview(pricelabel)
        addSubview(descriptLabel)
        addSubview(sellerName)
        addSubview(sellerSurName)
        addSubview(email)
        addSubview(phone)
        addSubview(callSeller)
        addSubview(sellerImage)
     
        
   
        
        Helper.tamicOff(views: [backToCatalog,imageView,imageView2,imageView3,imageView4,titleLabel,pricelabel,descriptLabel,sellerName,sellerSurName,email,phone,callSeller,sellerImage, miniatures])
//        backToCatalog.setBackgroundImage(UIImage(systemName: "arrow.left.square"), for: .normal)
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        miniatures.backgroundColor = .clear
                
//        imageView2.layer.cornerRadius = 12
//        imageView2.clipsToBounds = true
       
        titleLabel.text = item.name
        titleLabel.numberOfLines = 3
        titleLabel.font = titleLabel.font.withSize(20)
        
        pricelabel.text = "\(item.price) руб."
        pricelabel.font = pricelabel.font.withSize(24)
        pricelabel.textColor = .blue
        
        descriptLabel.text = item.descript
        descriptLabel.adjustsFontSizeToFitWidth = true
        descriptLabel.numberOfLines = 3
        
        sellerName.text = "Продавец: \(item.seller.firstName)"
        sellerSurName.text = item.seller.surname
        
        email.text = item.seller.email
        email.font = email.font.withSize(24)
        
        phone.text = " +7\(item.seller.phone)"
        phone.font = phone.font.withSize(36)
        
        callSeller.titleLabel?.textAlignment = NSTextAlignment.center
      
       
        self.sellerImage.layer.cornerRadius = 12
        self.sellerImage.clipsToBounds = true
    }
    
    
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([miniatures.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
                                     miniatures.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 4),
                                     miniatures.centerXAnchor.constraint(equalTo: centerXAnchor),
                                     miniatures.heightAnchor.constraint(equalToConstant: 80)])

        
        NSLayoutConstraint.activate([sellerImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
                                     sellerImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -88),
                                     sellerImage.widthAnchor.constraint(equalToConstant: 120),
                                     sellerImage.heightAnchor.constraint(equalToConstant: 120)])
        
        
        let stack = UIStackView(arrangedSubviews: [sellerName,sellerSurName], axis: .horizontal, spacing: 5)
        stack.translatesAutoresizingMaskIntoConstraints = false
         addSubview(stack)
        
        
        NSLayoutConstraint.activate([callSeller.widthAnchor.constraint(equalToConstant: 440),
                                     callSeller.leadingAnchor.constraint(equalTo: leadingAnchor),
                                     callSeller.heightAnchor.constraint(equalToConstant: 150),
                                     callSeller.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)])
       
        NSLayoutConstraint.activate([phone.topAnchor.constraint(equalTo: email.bottomAnchor, constant: 24),
                                     phone.leadingAnchor.constraint(equalTo: stack.leadingAnchor)])
        
        
        NSLayoutConstraint.activate([email.topAnchor.constraint(equalTo: stack.bottomAnchor, constant: 24),
                                     email.leadingAnchor.constraint(equalTo: stack.leadingAnchor)])
        
        NSLayoutConstraint.activate([stack.topAnchor.constraint(equalTo: descriptLabel.bottomAnchor,constant: 72),
                                     stack.leadingAnchor.constraint(equalTo: descriptLabel.leadingAnchor)])
        
        NSLayoutConstraint.activate([descriptLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 24),
                                     descriptLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
                                     descriptLabel.widthAnchor.constraint(equalToConstant: 240)])
        
        NSLayoutConstraint.activate([pricelabel.centerYAnchor.constraint(equalTo: centerYAnchor),
                                     pricelabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12)])
        
        NSLayoutConstraint.activate([titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
                                     titleLabel.widthAnchor.constraint(equalToConstant: 240),
                                     titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12)])
        
        
// //       NSLayoutConstraint.activate([backToCatalog.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
////                                     backToCatalog.topAnchor.constraint(equalTo: topAnchor, constant: 12),
////                                     backToCatalog.widthAnchor.constraint(equalToConstant: 40),
//                                     backToCatalog.heightAnchor.constraint(equalToConstant: 40)])

        NSLayoutConstraint.activate([imageView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
                                     imageView.heightAnchor.constraint(equalToConstant: 240),
                                     imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
                                     imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0)])
        
        NSLayoutConstraint.activate([imageView2.widthAnchor.constraint(equalToConstant: 80),
                                     imageView2.heightAnchor.constraint(equalToConstant: 80),
                                     imageView2.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 6),
                                     imageView2.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20)])
        
        NSLayoutConstraint.activate([imageView3.widthAnchor.constraint(equalToConstant: 80),
                                     imageView3.heightAnchor.constraint(equalToConstant: 80),
                                     imageView3.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 96),
                                     imageView3.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20)])
        
        NSLayoutConstraint.activate([imageView4.widthAnchor.constraint(equalToConstant: 80),
                                     imageView4.heightAnchor.constraint(equalToConstant: 80),
                                     imageView4.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 186),
                                     imageView4.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20)])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func createLayout() -> UICollectionViewLayout {
        
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnviorment) -> NSCollectionLayoutSection in
            
            return self.createMiniatures()
            
        }
        
        return layout
        
    }
    
    private func createMiniatures () -> NSCollectionLayoutSection {
        
        //item
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(80),
                                                 heightDimension: .fractionalHeight(1))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        //group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .fractionalHeight(1))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 4)
        
        group.interItemSpacing = .fixed(6)
        
        
        
        //section
        
        let section = NSCollectionLayoutSection(group: group)
        
        section.interGroupSpacing = 6
        section.orthogonalScrollingBehavior = .continuous
        
        
        
        
        return section
        
        
    }
    
}

