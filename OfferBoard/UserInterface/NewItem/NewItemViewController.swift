//
//  NewItemViewController.swift
//  OfferBoard
//
//  Created by Рафаил Фаталиев on 18.06.2021.
//

import UIKit
import ImagePicker

class NewItemViewController: UIViewController {
    
    var photos = [UIImage]()
    let newItemView = NewItemView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view = newItemView
        newItemView.photosCollection.dataSource = self
        newItemView.photosCollection.delegate = self
        addTargets()
        
    }
    
    func addTargets() {
        
        newItemView.addPhotosButton.addTarget(self, action: #selector(addPhotos), for: .touchUpInside)
        
        newItemView.saveButton.addTarget(self, action: #selector(publicateItem), for: .touchUpInside)
        
    }
    
    @objc func publicateItem() {
        
        guard let name = newItemView.titleTextField.text,
              let price = Int(newItemView.priceTextField.text!),
              let address = newItemView.addressTextField.text,
              let descript = newItemView.descriptionTextField.text
        else {
            return
        }
        
        
        
        let item = RFProducts(id: UUID().uuidString,
                          name: name,
                          price: price,
                          descript: descript,
                          imgUrl: "",
                          gallery: [],
                          address: address,
                          seller: RFProfile(email: "",
                                            firstName: "",
                                            surname: "",
                                            phone: "",
                                            imageUrl: ""))
        
        AlomoFireManager.addItem(item: item, photos: photos) { result in
            
            
            switch result {
            case .success(_):
                let okAction = UIAlertAction(title: "Ок", style: .default) { _ in
                    self.dismiss(animated: true, completion: nil)
                }
                self.showAlert(title: "Успех!", text: "Ваш товар успешно добавлен", buttons: [okAction])
            case .failure(let error):
                let okAction = UIAlertAction(title: "Ок", style: .default, handler: nil)
                self.showAlert(title: "Ошибка!", text: error.localizedDescription, buttons: [okAction])
            }
        }
    }
    
    @objc func addPhotos() {
        
        guard photos.count < 7 else {
            let button = UIAlertAction(title: "ОК", style: .default, handler: nil)
            showAlert(title: nil, text: "Можно добавлять до 7 фотографий", buttons: [button])
            return
        }
        
        let imagePicker = ImagePickerController()
        imagePicker.delegate = self
        imagePicker.imageLimit = 7 - photos.count
        present(imagePicker, animated: true, completion: nil)
        
    }

}

extension NewItemViewController: ImagePickerDelegate {
    
    func wrapperDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        
    }
    
    func doneButtonDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        for img in images {
            photos.append(img)
        }
        
        newItemView.photosCollection.reloadData()
        imagePicker.dismiss(animated: true, completion: nil)
        
    }
    
    func cancelButtonDidPress(_ imagePicker: ImagePickerController) {
        imagePicker.dismiss(animated: true, completion: nil)
    }
}


extension NewItemViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCell.reuseId, for: indexPath) as! PhotoCell
        
        cell.imageView.image = photos[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        
        let yesButton = UIAlertAction(title: "Да", style: .destructive) { _ in
            self.photos.remove(at: indexPath.item)
            self.newItemView.photosCollection.reloadData()
        }
        
        let noButton = UIAlertAction(title: "Нет", style: .cancel, handler: nil)
        
        
        showAlert(title: "Удалить изображение?", text: nil, buttons: [noButton, yesButton])
        
    }
}
