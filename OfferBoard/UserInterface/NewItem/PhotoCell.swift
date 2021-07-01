//
//  PhotosCollection.swift
//  OfferBoard
//
//  Created by Рафаил Фаталиев on 20.06.2021.
//

import UIKit

class PhotosCollection: UICollectionViewCell {
    
    static let reuseId = "PhotoCell"
    var imageView = UIImageView()
    let trashView = UIImageView(image: UIImage(systemName: "trash.circle"))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .orange
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        trashView.alpha = 0.7
        trashView.tintColor = .white
        trashView.contentMode = .scaleAspectFill
        
        addSubview(imageView)
        addSubview(trashView)
        
        Helper.tamicOff(views: [trashView, imageView])
        imageView.clipsToBounds = true
        trashView.clipsToBounds = true
        

        NSLayoutConstraint.activate([imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
                                     imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
                                     imageView.topAnchor.constraint(equalTo: topAnchor),
                                     imageView.bottomAnchor.constraint(equalTo: bottomAnchor)])
        
        NSLayoutConstraint.activate([trashView.heightAnchor.constraint(equalToConstant: 60),
                                     trashView.widthAnchor.constraint(equalToConstant: 60),
                                     trashView.centerXAnchor.constraint(equalTo: centerXAnchor),
                                     trashView.centerYAnchor.constraint(equalTo: centerYAnchor)])
        
        imageView.backgroundColor = RFColors.lightGray
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
