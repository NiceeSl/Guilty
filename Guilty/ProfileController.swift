//
//  ProfileController.swift
//  Guilty
//
//  Created by Вячеслав Герасимов on 23.02.2023.
//
import PhotosUI
import UIKit

class ProfileController: UIViewController {

    @IBOutlet weak var mainPhoto: UIImageView!
    @IBOutlet weak var hiddenPhoto: UIImageView!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var warningPhoto: UILabel!
    
    @IBAction func continueAction(_ sender: UIButton) {
//        if(mainPhoto == nil) {
//            warningPhoto.isHidden = false
//        }
    }
    
    @IBAction func mainPhotoButton(_ sender: UIButton) {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
    @IBAction func hiddenPhotoButton(_ sender: UIButton) {
        let config = PHPickerConfiguration()
        
        let phPickerVC = PHPickerViewController(configuration: config)
        self.present(phPickerVC, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        warningPhoto.isHidden = true

    }
    
    override func viewWillAppear(_ animated: Bool) {
//        if (mainPhoto != nil) {
//            continueButton.setImage(UIImage(named: "Botton red norma"), for: .normal)
//        }
    }

}

extension ProfileController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
            mainPhoto.image = image
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
