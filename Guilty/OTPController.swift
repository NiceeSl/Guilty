//
//  OTPController.swift
//  Guilty
//
//  Created by Вячеслав Герасимов on 13.02.2023.
//

import UIKit

class OTPController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var tf1: UITextField!
    @IBOutlet weak var tf2: UITextField!
    @IBOutlet weak var tf3: UITextField!
    @IBOutlet weak var tf4: UITextField!
    @IBOutlet weak var timerLBL: UILabel!
    @IBOutlet weak var secLbl: UILabel!
    @IBOutlet weak var callAgainLbl: UILabel!
    @IBOutlet weak var callAgainButton: UIButton!
    
    @IBAction func callAgainAction(_ sender: UIButton) {
        callAgainLbl.isHidden = false
        secLbl.isHidden = false
        callAgainButton.isHidden = true
        time = 5
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(tick), userInfo: nil, repeats: true)
    }
    
    var timer = Timer()
    var time = 5 {
        didSet {
            timerLBL.text = "\(time)"
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(tick), userInfo: nil, repeats: true)
    }
    
    @objc func tick() {
        time -= 1
        if time == 0 {
            timer.invalidate()
            callAgainLbl.isHidden = true
            secLbl.isHidden = true
            callAgainButton.isHidden = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShowNotification), name: UIResponder.keyboardWillShowNotification, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHideNotification), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        self.tf1.delegate = self
        self.tf2.delegate = self
        self.tf3.delegate = self
        self.tf4.delegate = self
        
        self.tf1.addTarget(self, action: #selector(self.changeCharacter), for: .editingChanged)
        self.tf2.addTarget(self, action: #selector(self.changeCharacter), for: .editingChanged)
        self.tf3.addTarget(self, action: #selector(self.changeCharacter), for: .editingChanged)
        self.tf4.addTarget(self, action: #selector(self.changeCharacter), for: .editingChanged)
        
        callAgainLbl.isHidden = false
        secLbl.isHidden = false
        callAgainButton.isHidden = true
        
    }
    
    @objc func changeCharacter(textField: UITextField) {
        if textField.text?.utf8.count == 1 {
            switch textField {
            case tf1:
                tf2.becomeFirstResponder()
            case tf2:
                tf3.becomeFirstResponder()
            case tf3:
                tf4.becomeFirstResponder()
            case tf4:
                print("OTP = \(tf1.text!)\(tf2.text!)\(tf3.text!)\(tf4.text!)")
            default:
                break
            }
        }
        else if textField.text!.isEmpty {
            switch textField {
            case tf4:
                tf3.becomeFirstResponder()
            case tf3:
                tf2.becomeFirstResponder()
            case tf2:
                tf1.becomeFirstResponder()
            default:
                break
            }
        }
    }
    
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

extension OTPController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.text!.utf16.count == 1 && !string.isEmpty {
            return false
        } else {
            return true
        }
    }
}
