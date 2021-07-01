//
//  MyItemCcel.swift
//  OfferBoard
//
//  Created by Рафаил Фаталиев on 04.06.2021.
//

import UIKit

class MyItemCell: UITableViewCell {
    
    static let reuseId = "MyItemCell"
    let itemImageView = UIImageView(image: UIImage(named: "witcher.jpg"))
    let titleLabel = UILabel(text: "Вешалка для одежды", font: RFFonts.boldTextFont)
    let priceLabel = UILabel(text: "12 000 R", font: RFFonts.regularTextFont)

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: MyItemCell.reuseId)
        
        
        
        let stack = UIStackView(arrangedSubviews: [itemImageView, titleLabel, priceLabel], axis: .horizontal, spacing: 4)
        
        addSubview(stack)
        Helper.tamicOff(views: [itemImageView, stack, titleLabel, priceLabel])
        
        NSLayoutConstraint.activate([stack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
                                     stack.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 2),
                                     stack.topAnchor.constraint(equalTo: topAnchor, constant: 2),
                                     stack.centerYAnchor.constraint(equalTo: centerYAnchor)])
        
        NSLayoutConstraint.activate([itemImageView.widthAnchor.constraint(equalToConstant: 60),
                                     itemImageView.heightAnchor.constraint(equalTo: itemImageView.widthAnchor),
                                     priceLabel.widthAnchor.constraint(equalToConstant: 80)])
                                    

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
