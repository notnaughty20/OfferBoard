//
//  ItemCell.swift
//  OfferBoard
//
//  Created by Рафаил Фаталиев on 07.06.2021.
//

import UIKit

class ItemCell: UICollectionViewCell {
    
    static let reuseId: String = "SaleCell"
    let imageView = UIImageView()
    let titleLabel = UILabel(text: "Матрешка из пластилина", font: RFFonts.regularTextFont)
    let priceLabel = UILabel(text: "500 р", font: RFFonts.boldTextFont)
    let cardView = UIView()
    let grayView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
        setupSubviews()
        
    }
    
    func setupSubviews() {
        cardView.backgroundColor = .blue
        titleLabel.textColor = .white
        priceLabel.textColor = .white
        
        imageView.contentMode = .scaleAspectFill
        cardView.layer.cornerRadius = 12
        cardView.clipsToBounds = true
    }
    
    func setupConstraints() {
        
        addSubview(cardView)
        cardView.addSubview(imageView)
        cardView.addSubview(grayView)

        cardView.addSubview(titleLabel)
        cardView.addSubview(priceLabel)

        
        grayView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.2198365066)
        
        Helper.tamicOff(views: [cardView,
                                imageView,
                                titleLabel,
                                priceLabel,
                                grayView
        ])
        
        NSLayoutConstraint.activate([cardView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
                                     cardView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
                                     cardView.centerXAnchor.constraint(equalTo: centerXAnchor),
                                     cardView.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
        
        NSLayoutConstraint.activate([titleLabel.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -4),
                                     titleLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 6),
                                     titleLabel.centerXAnchor.constraint(equalTo: cardView.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([priceLabel.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -2),
                                     priceLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 6),
                                     priceLabel.centerXAnchor.constraint(equalTo: cardView.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([grayView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor),
                                     grayView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor),
                                     grayView.centerXAnchor.constraint(equalTo: cardView.centerXAnchor),
                                     grayView.heightAnchor.constraint(equalToConstant: 52)
        ])
        
    }
    
    
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
