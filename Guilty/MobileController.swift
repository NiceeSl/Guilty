//
//  MobileController.swift
//  Guilty
//
//  Created by Вячеслав Герасимов on 13.02.2023.
//

import UIKit

class MobileController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var countryBtn: UIButton!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    
    @IBAction func countryButton(_ sender: UIButton) {
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CountryViewController") as! CountryViewController
        navigationController?.pushViewController(controller, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyBoard()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShowNotification), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHideNotification), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let country = country ?? getCountry(code: "RU")
        let title = "\(country.countryFlag!) +\(country.extensionCode!)"
        countryBtn.setTitle(title, for: .normal)
    }
    
    var country: Country?
    
    
    @objc func keyboardWillShowNotification(notification: Notification) {
        if let frame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let height = frame.cgRectValue.height
            self.scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.scrollView.contentSize.height + height)
        }
    }
    
    @objc func keyboardWillHideNotification(notification: Notification) {
        if let frame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let height = frame.cgRectValue.height
            self.scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.scrollView.contentSize.height - height)
        }
    }
    
}
