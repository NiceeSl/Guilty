//
//  hiddenPhotosController.swift
//  Guilty
//
//  Created by Вячеслав Герасимов on 26.02.2023.
//

import UIKit
import PhotosUI

class hiddenPhotosController: UIViewController {

    @IBOutlet weak var photoCollectionView: UICollectionView!
    
    @IBAction func addPhotoButton(_ sender: UIButton) {
        var config = PHPickerConfiguration()
        config.selectionLimit = 10
        let phPickerVC = PHPickerViewController(configuration: config)
        phPickerVC.delegate = self
        self.present(phPickerVC, animated: true)
    }
    
    var imageArray = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func backButtonAction(_ sender: UIButton) {
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProfileController") as! ProfileController
        controller.modalPresentationStyle = .fullScreen
        present(controller, animated: true, completion: nil)
    }
    
    @IBAction func deleteHiddenPhotoAction(_ sender: UIButton) {
        
    }
}

extension hiddenPhotosController: PHPickerViewControllerDelegate {
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        dismiss(animated: true)
        for result in results {
            result.itemProvider.loadObject(ofClass: UIImage.self) {object, error in
                if let image = object as? UIImage {
                    self.imageArray.append(image)
                }
                DispatchQueue.main.async {
                    self.photoCollectionView.reloadData()
                }
            }
        }
    }
}

extension hiddenPhotosController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        imageArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as? PhotoCell else {
            return UICollectionViewCell()
        }
        cell.photoView.image = imageArray[indexPath.row]
        return cell
    }

}

extension hiddenPhotosController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.size.width / 3, height: collectionView.frame.size.height / 5 )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
}
