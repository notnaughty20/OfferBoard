//
//  CatalogViewController.swift
//  OfferBoard
//
//  Created by Рафаил Фаталиев on 31.05.2021.
//

import UIKit

class CatalogViewController: UIViewController {
    
    let catalogView = CatalogView()
    var currentPage = 1
    var items = [RFProducts]()
    var pageCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.view = catalogView
        navigationController?.navigationBar.isHidden = true
        getItems(page: 1)
        catalogView.collectionView.dataSource = self
        catalogView.collectionView.delegate = self
        
    }
    
    func getItems(page: Int) {
        AlomoFireManager.getItems(page: page) { result in
            
            switch result {
            
            case .success(let items, let pageCount):
                self.items += items
                self.currentPage += 1
                self.pageCount = pageCount
                self.catalogView.collectionView.reloadData()
            case .failure(_):
                print("Не удалось получить товары")
            }
            
        }
    }
}

extension CatalogViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemCell.reuseId, for: indexPath) as! ItemCell
        
        cell.titleLabel.text = items[indexPath.item].name
        cell.priceLabel.text = "\(items[indexPath.item].price) руб"
        
        let url = items[indexPath.item].imgUrl
        AlomoFireManager.downloadImage(url: url) { result in
            
            switch result {
            case .success(let image):
                cell.imageView.image = image
            case .failure(let error):
                print(error.localizedDescription)
            }

        
            
            
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let id = items[indexPath.item].id
        
        AlomoFireManager.getItem(id: id) { result in
            
            switch result {
            
            case .success(let item):
                print(item.seller.phone)
                let vc = ItemViewController(item: item)
                vc.modalPresentationStyle = .currentContext
                self.present(vc, animated: true, completion: nil)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        if catalogView.collectionView.contentOffset.y >= catalogView.collectionView.contentSize.height - catalogView.collectionView.frame.size.height {
            
//            if self.pageCount > self.currentPage {
//
//            } else {
//
//            }
            currentPage += 1
            self.getItems(page: currentPage)
            print("Скроллинг вверх")
        } else {
            self.items.removeAll()
            catalogView.collectionView.reloadData()
            currentPage = 1
            self.getItems(page: currentPage)
            print("Скроллинг Вниз")
        }
    }
}



