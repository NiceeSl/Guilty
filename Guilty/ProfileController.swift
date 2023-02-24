//
//  ProfileController.swift
//  Guilty
//
//  Created by Вячеслав Герасимов on 23.02.2023.
//
import PhotosUI
import UIKit

class ProfileController: UIViewController, UITextFieldDelegate{
    
    @IBOutlet weak var mainPhoto: UIImageView!
    @IBOutlet weak var hiddenPhoto: UIImageView!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var warningLbl: UILabel!
    @IBOutlet weak var photoProfileLbl: UILabel!
    @IBOutlet weak var hiddenPhotoLbl: UILabel!
    @IBOutlet weak var loginField: UITextField!
    
    @IBAction func continueAction(_ sender: UIButton) {
        if (isValid == false) {
            
        }
        else if (isValid == true) {
            let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PersonalInfoController") as! PersonalInfoController
            navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    var isValid: Bool = false
    
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
        warningLbl.isHidden = true
        loginField.delegate = self
        
    }
    
    func disableContinueButton() {
        continueButton.setImage(UIImage(named: "Botton red "), for: .normal)
        isValid = false
        warningLbl.isHidden = false
    }
    
    func validateLoginField(newLoginSymbol: String) -> Bool {
        var loginFieldValue = (loginField?.text ?? "")
        if (newLoginSymbol == "") {
            loginFieldValue.removeLast()
        } else {
            loginFieldValue.append(newLoginSymbol)
        }
        if (loginFieldValue.isEmpty) {
            disableContinueButton()
            return false
        }
        let loginMatchPattern = loginFieldValue.range(of: "^[a-z0-9.]+$", options: .regularExpression, range: nil, locale: nil)
        if (loginMatchPattern == nil) {
            disableContinueButton()
            warningLbl.text = "Имя пользователя содержит недопустимые символы"
            return false
        }
        return true
    }
    
    func validateMainPhoto() -> Bool {
        if(mainPhoto.image == nil) {
            disableContinueButton()
            warningLbl.text = "Обязательное поле"
            return false
        }
        photoProfileLbl.textColor = .white
        return true
    }
    
    func validate(newLoginSymbol: String) {
        if (validateLoginField(newLoginSymbol: newLoginSymbol) && validateMainPhoto()) {
            isValid = true
            continueButton.setImage(UIImage(named: "Botton red norma"), for: .normal)
            warningLbl.isHidden = true
        } else {
            isValid = false
            continueButton.setImage(UIImage(named: "Botton red"), for: .normal)
            warningLbl.isHidden = false
        }
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString newSymbol: String) -> Bool {
        validate(newLoginSymbol: newSymbol)
        return true
    }
    
}
extension ProfileController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
            mainPhoto.image = image
        }
        validateMainPhoto()
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

private var __maxLengths = [UITextField: Int]()
extension UITextField {
    @IBInspectable var maxLength: Int {
        get {
            guard let l = __maxLengths[self] else {
                return 150
            }
            return l
        }
        set {
            __maxLengths[self] = newValue
            addTarget(self, action: #selector(fix), for: .editingChanged)
        }
    }
    @objc func fix(textField: UITextField) {
        if let t = textField.text {
            textField.text = String(t.prefix(maxLength))
        }
    }
}

