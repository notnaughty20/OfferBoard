//
//  MiniaturCellCollectionViewCell.swift
//  OfferBoard
//
//  Created by Рафаил Фаталиев on 14.06.2021.
//

import UIKit

class MiniatureCell: UICollectionViewCell {
    
    static var reuseId: String = "MiniatureCell"
    
    let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(imageView)
        
        Helper.tamicOff(views: [imageView])
        
        
        NSLayoutConstraint.activate([imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
                                     imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
                                     imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
                                     imageView.topAnchor.constraint(equalTo: topAnchor)])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
