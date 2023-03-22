//
//  WrongCodeController.swift
//  Guilty
//
//  Created by Вячеслав Герасимов on 24.02.2023.
//

import UIKit

class WrongCodeController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        time = 2
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(tick), userInfo: nil, repeats: true)
    }
    
    var timer = Timer()
    var time = 2
    
    @objc func tick() {
        time -= 1
        if time == 0 {
            let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "OTPController") as! OTPController
            controller.modalPresentationStyle = .fullScreen
            present(controller, animated: true, completion: nil)
        }
    }
}
