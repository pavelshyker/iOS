//
//  SettingsViewController.swift
//  GameProject
//
//  Created by Pavel Shyker on 9/28/20.
//  Copyright © 2020 Pavel Shyker. All rights reserved.
//

import UIKit
import AVKit

class SettingsViewController: UIViewController {
    var name: String = "Player"
    var carColor: String = "Red"
    var isSoundNeeded: Bool = true
    var isSoundShouldBeRestarted: Bool = false
    var isAccelerometerNeeded: Bool = true
    var originSoundOption: Int = 0
    var selectedSoundOption: Int = 0
    var selectedAccelerometertOption: Int = 0
    var startSoundPlayer: AVAudioPlayer?
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var carColorSegmentControl: UISegmentedControl!
    @IBOutlet weak var soundSettingsSegmentControl: UISegmentedControl!
    @IBOutlet weak var accelerometerSettingsSegmentControl: UISegmentedControl!
    
    @IBOutlet weak var applyButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        applyButton.setCornerRadius(radius: applyButton.frame.size.height/2)
        applyButton.setShadow(opacity: 0.7, radius: 5)

        carColor = UserDefaults.standard.value(forKey: .carColor) as? String ?? "Red"
        isSoundNeeded = UserDefaults.standard.value(forKey: .sound) as? Bool ?? true
        name = UserDefaults.standard.value(forKey: .userName) as? String ?? "Player"
        isAccelerometerNeeded = UserDefaults.standard.value(forKey: .accelerometer) as? Bool ?? true
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(
            handleTap(_:)))
        view.addGestureRecognizer(tapGestureRecognizer)
        
        nameTextField.returnKeyType = UIReturnKeyType.done
        nameTextField.delegate = self
    }
    
    func playStartGameSound() {
        if isSoundNeeded == true {
        if let carStartSoundPath = Bundle.main.path(forResource: "carStartSound", ofType: "mp3") {
            let carStartSoundUrl = URL(fileURLWithPath: carStartSoundPath)
            do {
                startSoundPlayer = try AVAudioPlayer(contentsOf: carStartSoundUrl)
            }
            catch {
                print (error.localizedDescription)
            }
            startSoundPlayer?.play()
            }
        }
    }
    
    @objc func handleTap(_ gesture: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if carColor == "Yellow" {
            carColorSegmentControl.selectedSegmentIndex = 1
        }
        else {
            carColorSegmentControl.selectedSegmentIndex = 0
        }
        
        if isSoundNeeded == true {
            soundSettingsSegmentControl.selectedSegmentIndex = 0
        }
        else {
            soundSettingsSegmentControl.selectedSegmentIndex = 1
        }
        
        if isAccelerometerNeeded == true {
            accelerometerSettingsSegmentControl.selectedSegmentIndex = 0
        }
        else {
            accelerometerSettingsSegmentControl.selectedSegmentIndex = 1
        }
        
        nameTextField.text = name
        originSoundOption = soundSettingsSegmentControl.selectedSegmentIndex
    }
    
    @IBAction func applyButtonTapped(_ sender: Any) {
        name = nameTextField.text ?? "Player"
        UserDefaults.standard.setValue(name, forKey: .userName)
        
        carColor = carColorSegmentControl.titleForSegment(at: carColorSegmentControl.selectedSegmentIndex) ?? "Red"
        UserDefaults.standard.setValue(carColor, forKey: .carColor)
        
        selectedSoundOption = soundSettingsSegmentControl.selectedSegmentIndex
        selectedAccelerometertOption = accelerometerSettingsSegmentControl.selectedSegmentIndex
        
        rememberSoundOption(selectedSoundOption)
        rememberAccelerometerOption(selectedAccelerometertOption)
        rememberRestartNeededOption(originSoundOption, selectedSoundOption)
        
        self.navigationController?.popViewController(animated: true)
        self.playStartGameSound()
    }
    
    func rememberSoundOption(_ soundOption: Int) {
        if selectedSoundOption == 0 {
            isSoundNeeded = true
        }
        else {
            isSoundNeeded = false
        }
        UserDefaults.standard.setValue(isSoundNeeded, forKey: .sound)
    }
    
    func rememberAccelerometerOption(_ soundOption: Int) {
        if selectedAccelerometertOption == 0 {
            isAccelerometerNeeded = true
        }
        else {
            isAccelerometerNeeded = false
        }
        UserDefaults.standard.setValue(isAccelerometerNeeded, forKey: .accelerometer)
    }
    
    func rememberRestartNeededOption(_ originSoundOption: Int, _ selectedSoundOption: Int) {
        if originSoundOption != selectedSoundOption {
            isSoundShouldBeRestarted = true
        }
        else {
            isSoundShouldBeRestarted = false
        }
        UserDefaults.standard.setValue(isSoundShouldBeRestarted, forKey: .soundRestart)
    }
}

extension SettingsViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}
