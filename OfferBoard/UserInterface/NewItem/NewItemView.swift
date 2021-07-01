//
//  NewItemView.swift
//  OfferBoard
//
//  Created by Рафаил Фаталиев on 18.06.2021.
//


import UIKit

class NewItemView: UIView {
    
    var photos = [#imageLiteral(resourceName: "hand-painted-watercolor-background-with-sky-and-clouds-shape_24972-1105"), #imageLiteral(resourceName: "logo")]
    
    //Создать КоллекшнВью
    //Создать ячейку для КоллекшнВью, содержащую картинку и поверх неё полупрозрачное изображение корзины (его можно взять в SF Symbols)
    //Заполнить КолленшнВью картинками из массива photos
    
    let titleLabel = UILabel(text: "Добавить товар", font: RFFonts.titleLabelFont)
    let titleTextField = UITextField(placeholder: "Название")
    let priceTextField = UITextField(placeholder: "Цена")
    let descriptionTextField = UITextField(placeholder: "Описание товара")
    let addressTextField = UITextField(placeholder: "Откуда забрать?")
    let addPhotosButton = UIButton(title: "Добавить фото", backgroundColor: .clear, textColor: RFColors.darkBlue, font: RFFonts.boldTextFont, cornerRadius: 6)
    let saveButton = UIButton(title: "Опубликовать", backgroundColor: RFColors.darkBlue, textColor: .white, font: RFFonts.boldTextFont, cornerRadius: 0)
    var photosCollection: UICollectionView!
    
    
    init() {
        super.init(frame: CGRect())
        setupViews()
        setupPhotosCollectionView()
        setupConstraints()
    }
    
    func setupViews() {
        backgroundColor = RFColors.lightGray
    }
    
    func setupPhotosCollectionView() {
        
        photosCollection = UICollectionView(frame: CGRect(), collectionViewLayout: setupLayout())
        photosCollection.register(PhotoCell.self, forCellWithReuseIdentifier: PhotoCell.reuseId)
        photosCollection.backgroundColor = .clear
    }
    
    
    
    func setupConstraints() {
        
        let stackView = UIStackView(arrangedSubviews: [titleLabel,
                                                       titleTextField,
                                                       priceTextField,
                                                       descriptionTextField,
                                                       addressTextField,
                                                       addPhotosButton],
                                    axis: .vertical,
                                    spacing: 8)
        
        addSubview(saveButton)
        addSubview(stackView)
        addSubview(photosCollection)
        
        Helper.tamicOff(views: [stackView,
                                saveButton,
                                titleLabel,
                                titleTextField,
                                priceTextField,
                                descriptionTextField,
                                addressTextField,
                                photosCollection,
                                addPhotosButton])
        
        NSLayoutConstraint.activate([stackView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -120),
                                     stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
                                     stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32)
        ])
        
        NSLayoutConstraint.activate([saveButton.leadingAnchor.constraint(equalTo: leadingAnchor),
                                     saveButton.centerXAnchor.constraint(equalTo: centerXAnchor),
                                     saveButton.bottomAnchor.constraint(equalTo: bottomAnchor),
                                     saveButton.heightAnchor.constraint(equalToConstant: 80)
        ])
        
        NSLayoutConstraint.activate([photosCollection.topAnchor.constraint(equalTo: addPhotosButton.bottomAnchor, constant: 16),
                                     photosCollection.trailingAnchor.constraint(equalTo: addPhotosButton.trailingAnchor),
                                     photosCollection.leadingAnchor.constraint(equalTo: addPhotosButton.leadingAnchor),
                                     photosCollection.bottomAnchor.constraint(equalTo: saveButton.topAnchor, constant: -32)
        ])
        
        let array = [titleTextField, priceTextField, descriptionTextField, addressTextField]
        
        for view in array {
            
            NSLayoutConstraint.activate([view.heightAnchor.constraint(equalToConstant: 40)])
            
//            view.layer.borderWidth = 3
//            view.layer.borderColor = UIColor.black.cgColor
        }

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension NewItemView {
    
    func setupLayout() -> UICollectionViewLayout {
        
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in

            return self.createPhotos()
        }
        
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 30
        layout.configuration = config
        
        return layout
        
    }
    
    func createPhotos() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9),
                                              heightDimension: .fractionalHeight(0.9))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .fractionalWidth(0.45))
        
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
        
        let spacing = CGFloat(12)
        group.interItemSpacing = .fixed(spacing)
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = -2
        section.contentInsets = NSDirectionalEdgeInsets.init(top: 8, leading: 0, bottom: 0, trailing: 0)
        
        return section
    }
    
}
