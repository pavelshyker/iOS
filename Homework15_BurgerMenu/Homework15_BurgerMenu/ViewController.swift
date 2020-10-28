//
//  ViewController.swift
//  Homework15_BurgerMenu
//
//  Created by Pavel Shyker on 10/24/20.
//  Copyright © 2020 Pavel Shyker. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var burgerNebuIsOpened = false
    var animationTime: TimeInterval = 1
    @IBOutlet weak var blurView: UIVisualEffectView!
    @IBOutlet weak var burgerMenuButton: UIButton!
    @IBOutlet weak var burgerMenuView: UIView!
    @IBOutlet weak var burgerMenuWidthConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    
        //burgerMenuView.frame.origin = CGPoint(x: 0, y: 0)
        //burgerMenuView.frame.size.height = view.frame.size.height
        //burgerMenuView.frame.size.width = 0
        blurView.alpha = 0
        burgerMenuWidthConstraint.constant = self.view.frame.size.width
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction func burgerMenuButtonTapped(_ sender: Any) {
        animateBlurView(animationTime)
        animateBurgerMenu(animationTime)
        
    }
    
    private func animateBurgerMenu(_ time: TimeInterval) {
        if burgerNebuIsOpened == false {
            burgerMenuWidthConstraint.constant -= (self.view.frame.size.width - 110)
            UIView.animate(withDuration: time) {
                self.view.layoutIfNeeded()
            }
            burgerNebuIsOpened = true
        }
        else {
            burgerMenuWidthConstraint.constant = self.view.frame.size.width
            UIView.animate(withDuration: 1) {
                self.view.layoutIfNeeded()
            }
            burgerNebuIsOpened = false
        }
    }
    
    private func animateBlurView(_ time: TimeInterval) {
        UIView.animate(withDuration: time, animations: {
            if self.burgerNebuIsOpened == false {
                self.blurView.alpha = 1
            }
            else {
                self.blurView.alpha = 0
            }
        })
    }
    
}

/*
 UIView.animate(withDuration: 1, animations: {
 if !self.burgerNebuIsOpened {
 //self.burgerMenuView.frame.origin.x = 0
 self.burgerMenuView.frame.size.width = self.view.frame.size.width - 120
 self.burgerNebuIsOpened = true
 self.blurView.isHidden = false
 self.blurView.alpha = 1
 }
 else {
 self.burgerMenuView.frame.size.width = 0
 self.burgerNebuIsOpened = false
 self.blurView.isHidden = true
 self.blurView.alpha = 0
 }
 })
 */
