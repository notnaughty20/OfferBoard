//
//  ItemViewController.swift
//  OfferBoard
//
//  Created by Рафаил Фаталиев on 11.06.2021.
//

import UIKit
import SwiftPhotoGallery

class ItemViewController: UIViewController {

    let item: RFProducts
    let itemView : ItemView
    var photos = [UIImage]()
    var currentImageIndex = 0
    
    
    init(item:RFProducts){
        self.item = item
        self.itemView = ItemView(item:item)
        
        super.init(nibName: nil, bundle: nil)
        self.view = itemView
        addTargets()
        
        itemView.miniatures.delegate = self
        itemView.miniatures.dataSource = self
        
        for photo in item.gallery {
            let url = photo
            AlomoFireManager.downloadImage(url: url) { result in
                switch result {
                case .success(let image):
                    self.photos.append(image)
                    self.itemView.miniatures.reloadData()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    func addTargets() {
        
        let imageViewTap = UITapGestureRecognizer(target: self, action: #selector(openGallery))
        itemView.imageView.addGestureRecognizer(imageViewTap)
        itemView.callSeller.addTarget(self, action: #selector(call), for: .touchUpInside)
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(leftSwipe))
        leftSwipe.direction = .left
        itemView.imageView.addGestureRecognizer(leftSwipe)
        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(rightSwipe))
        rightSwipe.direction = .right
        itemView.imageView.addGestureRecognizer(rightSwipe)
        
        
    }
    @objc func leftSwipe() {
    
        var newIndex = 0
        
        switch currentImageIndex {
        case 0...(photos.count - 2):
            newIndex = currentImageIndex + 1
        default:
            newIndex = 0
        }
        currentImageIndex = newIndex
        
        UIView.transition(with: itemView.imageView,
                          duration: 0.3,
                          options: .transitionFlipFromRight) {
            self.itemView.imageView.image = self.photos[newIndex]
        } completion: { _ in
            
        }

        self.itemView.imageView.image = photos[newIndex]
        
        
    }
    @objc func rightSwipe() {
        
        var newIndex = 0
        
        switch currentImageIndex {
        case 0...(photos.count - 2):
            newIndex = currentImageIndex + -1
        default:
            newIndex = 0
        }
        currentImageIndex = newIndex
        
        UIView.transition(with: itemView.imageView,
                          duration: 0.3,
                          options: .transitionFlipFromRight) {
            self.itemView.imageView.image = self.photos[newIndex]
        } completion: { _ in
            
        }

        self.itemView.imageView.image = photos[newIndex]
    }
    
    @objc func openGallery() {
       
        let gallery = SwiftPhotoGallery(delegate: self, dataSource: self)
        gallery.backgroundColor = .black
        gallery.pageIndicatorTintColor = .gray
        gallery.currentPageIndicatorTintColor = .blue
        gallery.modalPresentationStyle = .fullScreen
        present(gallery, animated: true, completion: nil)
        
      
    }
    
    
    @objc func call() {
        if let url = NSURL(string: "tel://+7\(item.seller.phone)"), UIApplication.shared.canOpenURL(url as URL) {
            UIApplication.shared.open(URL(string: "tel://+7\(item.seller.phone)")!)
        }
    }
    @objc func dismissSelf() {
        self.dismiss(animated: true, completion: nil)
    }
    

}

extension ItemViewController: SwiftPhotoGalleryDelegate, SwiftPhotoGalleryDataSource {
    func galleryDidTapToClose(gallery: SwiftPhotoGallery) {
        dismiss(animated: true, completion: nil)
    }
    
    func numberOfImagesInGallery(gallery: SwiftPhotoGallery) -> Int {
        print(photos.count)
        return photos.count
    }
    
    func imageInGallery(gallery: SwiftPhotoGallery, forIndex: Int) -> UIImage? {
        return photos[forIndex]
    }
    
    
}


extension ItemViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MiniatureCell.reuseId, for: indexPath) as! MiniatureCell
        
        cell.imageView.image = photos[indexPath.item]
        cell.imageView.contentMode = .scaleAspectFill

        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.currentImageIndex = indexPath.item
        
        itemView.imageView.image = photos[currentImageIndex]
        
    }
    
}
