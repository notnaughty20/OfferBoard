//
//  CatalogViev.swift
//  OfferBoard
//
//  Created by Рафаил Фаталиев on 07.06.2021.
//

import UIKit

class CatalogView: UIView {
    
    let topView = UIView()
    var collectionView: UICollectionView!
    
    init() {
        super.init(frame: CGRect())
        backgroundColor = .white
        setupCollectionView()
        setupConstraints()
    }
    
    required init?(oder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        Helper.tamicOff(views: [collectionView])
        
        NSLayoutConstraint.activate([collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
                                     collectionView.centerXAnchor.constraint(equalTo: centerXAnchor),
                                     collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
                                     collectionView.topAnchor.constraint(equalTo: topAnchor, constant: 200)])
    }
    
    enum Section: Int, CaseIterable {
        
        case items
        
        func desctription() -> String {
            switch self {
            
            case .items:
                return "Товары"
            }
        }
        
    }
    
    private func setupCollectionView() {
        
        collectionView = UICollectionView(frame: CGRect(), collectionViewLayout: createCompositionalLayout())
        collectionView.backgroundColor = .white
        addSubview(collectionView)
        collectionView.register(ItemCell.self, forCellWithReuseIdentifier: ItemCell.reuseId)
        
    }
    
    private func createCompositionalLayout() -> UICollectionViewLayout {
        
        let layout = UICollectionViewCompositionalLayout { (section, layoutInviroment) -> NSCollectionLayoutSection in
            guard let section =  Section(rawValue: section) else { fatalError("Не получилось создать секцию") }
            
            switch section {
            
            case .items:
                return self.createSales()
            }

        }
        
        return layout
    }
    private func createSales() -> NSCollectionLayoutSection {
        
        //item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.45),
                                              heightDimension: .fractionalHeight(0.98))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        //group
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .fractionalWidth(0.4))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
        //section
        let spacing = CGFloat(8)
        group.interItemSpacing = .fixed(spacing)
        
        let section = NSCollectionLayoutSection(group: group)
        
        section.interGroupSpacing = 2
        
        section.contentInsets = NSDirectionalEdgeInsets.init(top: 8, leading: 12, bottom: 0, trailing: 12)
        
        return section
    
    }


}
