//
//  UIViewController + Aler.swift
//  Homework15_Alerts
//
//  Created by Pavel Shyker on 10/19/20.
//  Copyright © 2020 Pavel Shyker. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func createAlertOneOption(alertTitle: String, alertMessage: String? = nil, alertPreferredStyle: UIAlertController.Style = .alert) {
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: alertPreferredStyle)
        let action = UIAlertAction (title: "OK", style: .default, handler: { (_) in
            print ("OK button is tapped")
        })
        alert.addAction(action)
        //return alert
        present(alert, animated: true)
    }
    
    func createAlertTwoOptions(alertTitle: String, alertMessage: String? = nil, alertPreferredStyle: UIAlertController.Style = .alert) {
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: alertPreferredStyle)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: {
            (_) in
            print ("OK button is tapped")
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {
            (_) in
            print ("Cancel button is tapped")
            })
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
}

