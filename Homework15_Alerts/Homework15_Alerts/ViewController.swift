//
//  ViewController.swift
//  Homework15_Alerts
//
//  Created by Pavel Shyker on 10/19/20.
//  Copyright © 2020 Pavel Shyker. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private var textFieldLogin: UITextField?
    private var textFieldPassword: UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
         // Do any additional setup after loading the view.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
       
        let okAtion = UIAlertAction (title: "OK", style: .default, handler: { (_) in
            print (self.textFieldLogin?.text ?? "", self.textFieldPassword?.text ?? "") })
        
        let alert = UIAlertController (title: "Enter credentials", message: nil, preferredStyle: .alert)
        
        alert.addAction(okAtion)
        
        alert.addTextField {
            (textFieldLogin) in
            textFieldLogin.placeholder = "Insert login"
            textFieldLogin.isSecureTextEntry = false
            self.textFieldLogin = textFieldLogin
        }
        
        alert.addTextField {
            (textFieldPassword) in
            textFieldPassword.placeholder = "Insert password"
            textFieldPassword.isSecureTextEntry = true
            self.textFieldPassword = textFieldPassword
        }
        
         present(alert, animated: true)
        
        
        //createAlertOneOption(alertTitle: "AlertOneOption")
        //createAlertTwoOptions(alertTitle: "AllertTwoOptions")
    }
}

