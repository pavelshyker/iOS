//
//  ViewController.swift
//  Homework10_Calculator
//
//  Created by Pavel Shyker on 10/3/20.
//  Copyright © 2020 Pavel Shyker. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var firstValue: Double = 0
    var secondValue: Double = 0
    var stillTyping: Bool = false
    var operationSign = ""
    var result: Double = 0
    
    
    @IBOutlet weak var displayNubmerLabel: UILabel!
    
    @IBOutlet weak var oneNumberButton: UIButton!
    @IBOutlet weak var twoNumberButton: UIButton!
    @IBOutlet weak var threeNumberButton: UIButton!
    @IBOutlet weak var fourNumberButton: UIButton!
    @IBOutlet weak var fiveNumberButton: UIButton!
    @IBOutlet weak var sixNumberButton: UIButton!
    @IBOutlet weak var sevenNumberButton: UIButton!
    @IBOutlet weak var eightNumberButton: UIButton!
    @IBOutlet weak var nineNumberButton: UIButton!
    @IBOutlet weak var zeroNumberButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var changeSignButton: UIButton!
    @IBOutlet weak var persentageButton: UIButton!
    @IBOutlet weak var divideButton: UIButton!
    @IBOutlet weak var multiplyButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var equalButton: UIButton!
    @IBOutlet weak var doubleButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        oneNumberButton.layer.cornerRadius = oneNumberButton.frame.size.width/2
        twoNumberButton.layer.cornerRadius = twoNumberButton.frame.size.width/2
        threeNumberButton.layer.cornerRadius = threeNumberButton.frame.size.width/2
        fourNumberButton.layer.cornerRadius = fourNumberButton.frame.size.width/2
        fiveNumberButton.layer.cornerRadius = fiveNumberButton.frame.size.width/2
        sixNumberButton.layer.cornerRadius = sixNumberButton.frame.size.width/2
        sevenNumberButton.layer.cornerRadius = sevenNumberButton.frame.size.width/2
        eightNumberButton.layer.cornerRadius = eightNumberButton.frame.size.width/2
        nineNumberButton.layer.cornerRadius = nineNumberButton.frame.size.width/2
        zeroNumberButton.layer.cornerRadius = zeroNumberButton.frame.size.height/2
        resetButton.layer.cornerRadius = resetButton.frame.size.width/2
        changeSignButton.layer.cornerRadius = changeSignButton.frame.size.width/2
        persentageButton.layer.cornerRadius = persentageButton.frame.size.width/2
        divideButton.layer.cornerRadius = divideButton.frame.size.width/2
        multiplyButton.layer.cornerRadius = multiplyButton.frame.size.width/2
        minusButton.layer.cornerRadius = minusButton.frame.size.width/2
        plusButton.layer.cornerRadius = plusButton.frame.size.width/2
        equalButton.layer.cornerRadius = equalButton.frame.size.width/2
        doubleButton.layer.cornerRadius = doubleButton.frame.size.width/2
    }
    
    @IBAction func resetButtonTap(_ sender: UIButton) {
        displayNubmerLabel.text = "0"
        stillTyping = false
    }
    @IBAction func numberPressed(_ sender: UIButton) {
        
        let number = sender.currentTitle!
        
        if stillTyping == true {
        if displayNubmerLabel.text!.count < 9
        {
            
            if displayNubmerLabel.text == "0"
            {
                displayNubmerLabel.text = sender.currentTitle!
            }
            else {
                displayNubmerLabel.text = displayNubmerLabel.text! + sender.currentTitle!.trimmingCharacters(in: .whitespaces)
            }
            }
        }
        else {
            displayNubmerLabel.text! = number
            stillTyping = true
            }
        }
    
    @IBAction func operationButtonPressed(_ sender: UIButton) {
        firstValue = Double(displayNubmerLabel.text!)!
        stillTyping = false
        operationSign = sender.currentTitle!
    }
    
    @IBAction func equalButtonPressed(_ sender: UIButton) {
        secondValue = Double(displayNubmerLabel.text!)!
        
        switch operationSign {
        case "+" : result = firstValue + secondValue
        displayNubmerLabel.text = String(Int(result))
        firstValue = 0
        secondValue = 0
        stillTyping = false
        case "-": result = firstValue - secondValue
        displayNubmerLabel.text = String(Int(result))
        firstValue = 0
        secondValue = 0
        stillTyping = false
        case "×": result = firstValue * secondValue
        displayNubmerLabel.text = String(Int(result))
        firstValue = 0
        secondValue = 0
        stillTyping = false
        case "÷":
        result = firstValue / secondValue
        displayNubmerLabel.text = String(Int(result))
        firstValue = 0
        secondValue = 0
        stillTyping = false
        default: break
        }
    }
    
}
    
    
    
    

