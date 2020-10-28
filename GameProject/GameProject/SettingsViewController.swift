//
//  SettingsViewController.swift
//  GameProject
//
//  Created by Pavel Shyker on 9/28/20.
//  Copyright © 2020 Pavel Shyker. All rights reserved.
//

import UIKit

var name: String = ""
var carColor: String = ""

class SettingsViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var carColorSegmentControl: UISegmentedControl!
    @IBOutlet weak var applyButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        applyButton.setCornerRadius(radius: applyButton.frame.size.height/2)
        
        carColor = UserDefaults.standard.value(forKey: .carColor) 
        name = UserDefaults.standard.value(forKey: .userName)
        
          }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if carColor == "Yellow" {
            carColorSegmentControl.selectedSegmentIndex = 1
        }
        else {
            carColorSegmentControl.selectedSegmentIndex = 0
        }
        
        nameTextField.text = name
    }
    
    @IBAction func applyButtonTapped(_ sender: Any) {
        
        name = nameTextField.text ?? ""
        UserDefaults.standard.setValue(name, forKey: .userName)
        
        carColor = carColorSegmentControl.titleForSegment(at: carColorSegmentControl.selectedSegmentIndex) ?? "Red"
        UserDefaults.standard.setValue(carColor, forKey: .carColor)
        
        self.navigationController?.popViewController(animated: true)
    }
    

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
