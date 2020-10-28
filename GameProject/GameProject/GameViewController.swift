//
//  GameViewController.swift
//  GameProject
//
//  Created by Pavel Shyker on 9/28/20.
//  Copyright © 2020 Pavel Shyker. All rights reserved.
//

import UIKit

var initialRoad1: CGFloat = 0.0
var initialRoad2: CGFloat = 0.0
var timer: Timer = Timer()

class GameViewController: UIViewController {

    @IBOutlet weak var roadImage: UIImageView!
    @IBOutlet weak var blueCarImage: UIImageView!
    @IBOutlet weak var road2Image: UIImageView!
    @IBOutlet weak var redCarImage: UIImageView!
    @IBOutlet weak var leftTreeImage: UIImageView!
    @IBOutlet weak var rightTreeImage: UIImageView!
    @IBOutlet weak var leftStoneImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    // Do any additional setup after loading the view.
        carColor = UserDefaults.standard.value(forKey: .carColor)
        
        if carColor == "Yellow" {
            redCarImage.image = UIImage(named: "yellowCar")
        }
        else {
            redCarImage.image = UIImage(named: "redCar")
        }
    
        roadImage.center.x = view.center.x
        initialRoad1 = roadImage.frame.origin.y
        road2Image.frame.size.height = view.frame.size.height
        road2Image.frame.origin.y -= road2Image.frame.size.height
        initialRoad2 = road2Image.frame.origin.y
        
        blueCarImage.frame.origin.y = 0 - blueCarImage.frame.size.height
        redCarImage.frame.origin.y = view.frame.size.height + redCarImage.frame.size.height
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        road2Image.frame.size = roadImage.frame.size
        road2Image.center.x = view.center.x
        
        redCarImage.center.x = roadImage.center.x + roadImage.frame.size.width/4
        //redCarImage.frame.origin.y = view.frame.size.height - redCarImage.frame.size.height
        blueCarImage.center.x = roadImage.center.x - roadImage.frame.size.width/4
        
        animateRoad(3.0)
        animateLeftTree(4.0)
        animateRightTree(4.0)
        animateLeftStone(4.0)
        animateRedCar()
        animateBlueCar()
        
        
            timer = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true) { (_) in
            print (self.blueCarImage.frame.origin.y)
            if (self.blueCarImage.frame.origin.x...(self.blueCarImage.frame.origin.x + self.blueCarImage.frame.width)).contains(self.redCarImage.center.x) && ((self.blueCarImage.frame.origin.y...(self.blueCarImage.frame.origin.y + self.blueCarImage.frame.size.height)).contains(self.redCarImage.frame.origin.y))
            {
                //self.navigationController?.popViewController(animated: true)
                
                self.navigateToGameOverView()
                timer.invalidate()
            }
        }
    }
    
    @IBAction func leftDiractionButtonTap(_ sender: UIButton) {
        if  self.redCarImage.center.x != self.roadImage.center.x - self.roadImage.frame.size.width/4
        {
         UIImageView.animate(withDuration: 0.3, delay: 0, options: [], animations: {
            self.redCarImage.center.x = self.roadImage.center.x - self.roadImage.frame.size.width/4})
        }
        else {
            UIImageView.animate(withDuration: 0.2, delay: 0, options: [], animations: {
                self.redCarImage.center.x = self.roadImage.frame.origin.x
            }) {(result) in
                //self.navigationController?.popViewController(animated: true)
                self.navigateToGameOverView()
            }
        }
    }
    
    @IBAction func rightDiractionButtonTap(_ sender: UIButton) {
        if self.redCarImage.center.x != self.roadImage.center.x + self.roadImage.frame.size.width/4 {
         UIImageView.animate(withDuration: 0.3, delay: 0, options: [], animations: {
            self.redCarImage.center.x = self.roadImage.center.x + self.roadImage.frame.size.width/4})
        }
        else {
            UIImageView.animate(withDuration: 0.2, delay: 0, options: [], animations: {
                self.redCarImage.center.x = self.roadImage.frame.origin.x + self.roadImage.frame.width
            }) {(result) in
                self.navigateToGameOverView()
            }
        }
    }
    
    func animateRoad(_ time: CGFloat) {
        UIImageView.animate(withDuration: TimeInterval(time), delay: 0, options:[.curveLinear], animations: {
            self.roadImage.frame.origin.y = self.roadImage.frame.size.height
            self.road2Image.frame.origin.y = 0
        }) { (result) in
            self.roadImage.frame.origin.y = initialRoad1
            self.road2Image.frame.origin.y = initialRoad2
            self.animateRoad(time)
        }
    }
        
    func animateLeftTree(_ time: CGFloat) {
        let speed = ((self.roadImage.frame.size.height-self.leftTreeImage.frame.origin.y)*time)/self.roadImage.frame.size.height
        UIImageView.animate(withDuration: TimeInterval(speed), delay: 0, options: [.curveLinear], animations: {
                self.leftTreeImage.frame.origin.y = self.leftTreeImage.frame.origin.y + self.roadImage.frame.size.height
            }) { (result) in
                self.leftTreeImage.frame.origin.y = 0
                self.animateLeftTree(time)
            }
        }
    
    func animateRightTree(_ time: CGFloat) {
        let speed = ((self.roadImage.frame.size.height-self.rightTreeImage.frame.origin.y)*time)/self.roadImage.frame.size.height
        UIImageView.animate(withDuration: TimeInterval(speed), delay: 0, options: [.curveLinear], animations: {

            self.rightTreeImage.frame.origin.y =  self.roadImage.frame.size.height + self.rightTreeImage.frame.origin.y
            
        }) { (result) in
            self.rightTreeImage.frame.origin.y = 0
            self.animateRightTree(time)
        }
    }
    
    func animateLeftStone(_ time: CGFloat) {
        let speed = ((self.roadImage.frame.size.height - self.leftStoneImage.frame.origin.y) * time)/self.roadImage.frame.size.height
        UIImageView.animate(withDuration: TimeInterval(speed), delay: 0, options: [.curveLinear], animations: {
            
            self.leftStoneImage.frame.origin.y =  self.roadImage.frame.size.height + self.leftStoneImage.frame.origin.y
            
        }) { (result) in
            self.leftStoneImage.frame.origin.y = 0
            self.animateLeftStone(time)
        }
    }
    
    func animateBlueCar() {
        UIImageView.animate(withDuration: 0.05, delay: 0, options: [.curveLinear], animations: {
            
            self.blueCarImage.frame.origin.y += self.redCarImage.frame.size.height/10
            
        }) { (result) in
            if self.blueCarImage.frame.origin.y > self.roadImage.frame.size.height {
            self.blueCarImage.frame.origin.y = 0
            self.blueCarImage.center.x = [self.roadImage.center.x + self.roadImage.frame.size.width/4, self.roadImage.center.x - self.roadImage.frame.size.width/4].randomElement() ?? self.roadImage.center.x + self.roadImage.frame.size.width/4
            self.animateBlueCar()
            }
            else {
                self.animateBlueCar()
            }
            
    }
    }
        
        func animateRedCar() {
            if redCarImage.frame.origin.y == self.view.frame.size.height + redCarImage.frame.size.height {
                UIImageView.animate(withDuration: 1, delay: 0, options: [], animations: {
                    self.redCarImage.frame.origin.y = self.view.frame.size.height - self.redCarImage.frame.size.height

                })
        }
    }
    
    func navigateToGameOverView() {
        let gameOverStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let gameOverViewController = gameOverStoryboard.instantiateViewController(withIdentifier: String(describing: GameOverViewController.self)) as? GameOverViewController
        self.navigationController?.pushViewController(gameOverViewController ?? UIViewController(), animated: true)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
        
    /*
         func animateBlueCar() {
         UIImageView.animate(withDuration: TimeInterval(Float.random(in: 1.5...2.9)), delay: 0, options: [.curveLinear], animations: {
         
         self.blueCarImage.frame.origin.y =  self.roadImage.frame.size.height + self.blueCarImage.frame.origin.y
         
         }) { (result) in
         self.blueCarImage.frame.origin.y = 0
         self.blueCarImage.center.x = [self.roadImage.center.x + self.roadImage.frame.size.width/4, self.roadImage.center.x - self.roadImage.frame.size.width/4].randomElement() ?? self.roadImage.center.x + self.roadImage.frame.size.width/4
         self.animateBlueCar()
         
         }
         
         
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}
