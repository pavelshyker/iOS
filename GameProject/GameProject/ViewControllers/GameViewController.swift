//
//  GameViewController.swift
//  GameProject
//
//  Created by Pavel Shyker on 9/28/20.
//  Copyright © 2020 Pavel Shyker. All rights reserved.
//

import UIKit
import AVKit
import CoreMotion

class GameViewController: UIViewController {

    var score: Int = 0
    var initialRoad1: CGFloat = 0.0
    var initialRoad2: CGFloat = 0.0
    var timer: Timer = Timer()
    var carRidePlayer: AVAudioPlayer?
    var carTurnPlayer: AVAudioPlayer?
    var carCrushPlayer: AVAudioPlayer?
    var isGameStarted: Bool = false
    var isSoundNeeded: Bool = true
    var isAccelerometerNeeded: Bool = false
    var isShakeAnimationWork: Bool = false
    
    let coreMotionManager = CMMotionManager()
    
    @IBOutlet weak var roadImage: UIImageView!
    @IBOutlet weak var blueCarImage: UIImageView!
    @IBOutlet weak var road2Image: UIImageView!
    @IBOutlet weak var redCarImage: UIImageView!
    @IBOutlet weak var leftTreeImage: UIImageView!
    @IBOutlet weak var rightTreeImage: UIImageView!
    @IBOutlet weak var leftStoneImage: UIImageView!
    @IBOutlet weak var leftDirectionButton: UIButton!
    @IBOutlet weak var rightDirectionButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        isGameStarted = true
        rememberScoreValue()
        selectCarImageAccordingToColor()
        
        //set buttons size
        leftDirectionButton.frame.origin.x = 0
        leftDirectionButton.frame.origin.y = 0
        leftDirectionButton.frame.size.width = view.frame.size.width/2
        leftDirectionButton.frame.size.height = view.frame.size.height
        rightDirectionButton.frame.origin.x = view.center.x
        rightDirectionButton.frame.origin.y = 0
        rightDirectionButton.frame.size.width = view.frame.size.width/2
        rightDirectionButton.frame.size.height = view.frame.size.height
        
        //set roads size
        roadImage.center.x = view.center.x
        roadImage.frame.size.height = view.frame.size.height
        initialRoad1 = roadImage.frame.origin.y
        road2Image.frame.size.height = view.frame.size.height
        road2Image.frame.origin.y -= road2Image.frame.size.height
        initialRoad2 = road2Image.frame.origin.y
        
        //set cars size
        blueCarImage.frame.origin.y = 0 - blueCarImage.frame.size.height
        redCarImage.frame.origin.y = view.frame.size.height + redCarImage.frame.size.height
        
        //set trees and stone
        let difViewAndRoad = (view.frame.size.width - roadImage.frame.size.width)/2
        rightTreeImage.center.x = view.frame.size.width - difViewAndRoad + difViewAndRoad/3.5
        leftTreeImage.center.x = difViewAndRoad - difViewAndRoad/3.5
        leftStoneImage.center.x = difViewAndRoad - difViewAndRoad/3
        
        isSoundNeeded = UserDefaults.standard.value(forKey: .sound) as? Bool ?? true
        playCarSound()
        
        isAccelerometerNeeded = UserDefaults.standard.value(forKey: .accelerometer) as? Bool ?? false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if isGameStarted == true {
        road2Image.frame.size = roadImage.frame.size
        road2Image.center.x = view.center.x
        
        redCarImage.center.x = roadImage.center.x + roadImage.frame.size.width/4
        blueCarImage.center.x = roadImage.center.x - roadImage.frame.size.width/4
        
        animateRoad(3.0)
        animateLeftTree(4.0)
        animateRightTree(4.0)
        animateLeftStone(4.0)
        animateRedCar()
        animateBlueCar()
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { (_) in
            if self.isShakeAnimationWork == false {
            if ((self.blueCarImage.frame.origin.x < (self.redCarImage.frame.origin.x + self.redCarImage.frame.width)) && ((self.blueCarImage.frame.origin.x + self.blueCarImage.frame.width) > self.redCarImage.frame.origin.x) && (self.blueCarImage.frame.origin.y < (self.redCarImage.frame.origin.y + self.redCarImage.frame.height - 50)) && ((self.blueCarImage.frame.origin.y + self.blueCarImage.frame.height) > self.redCarImage.frame.origin.y))
            {
                self.navigateToGameOverView()
                self.isGameStarted = false
                self.rememberScoreValue()
                self.rememberRecordDate()
                self.timer.invalidate()
                }
            }
            }
        }
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            if isAccelerometerNeeded == true && isGameStarted == true {
                isShakeAnimationWork = true
                if redCarImage.frame.origin.y == self.view.frame.size.height - redCarImage.frame.size.height {
                    UIImageView.animate(withDuration: 0.6, delay: 0, options: [], animations: {
                        self.redCarImage.frame.size.width += 20
                        self.redCarImage.frame.size.height += 20
                    }) {(_) in
                    UIImageView.animate(withDuration: 0.6, delay: 0, options: [], animations: {
                        self.redCarImage.frame.size.width -= 20
                        self.redCarImage.frame.size.height -= 20
                    }) {(_) in
                        self.isShakeAnimationWork = false
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func leftDiractionButtonTap(_ sender: UIButton) {
        if isGameStarted == true {
        if  self.redCarImage.center.x != self.roadImage.center.x - self.roadImage.frame.size.width/4
        {
         UIImageView.animate(withDuration: 0.3, delay: 0, options: [], animations: {
            self.redCarImage.center.x = self.roadImage.center.x - self.roadImage.frame.size.width/4})
            self.playCarTurnSound()
        }
        else {
            UIImageView.animate(withDuration: 0.2, delay: 0, options: [], animations: {
                self.redCarImage.center.x = self.roadImage.frame.origin.x
            }) {(result) in
                self.navigateToGameOverView()
                self.isGameStarted = false
                self.rememberScoreValue()
                self.rememberRecordDate()
            }
            }
        }
    }
    
    @IBAction func rightDiractionButtonTap(_ sender: UIButton) {
        if isGameStarted == true {
        if self.redCarImage.center.x != self.roadImage.center.x + self.roadImage.frame.size.width/4 {
         UIImageView.animate(withDuration: 0.3, delay: 0, options: [], animations: {
            self.redCarImage.center.x = self.roadImage.center.x + self.roadImage.frame.size.width/4})
            self.playCarTurnSound()
        }
        else {
            UIImageView.animate(withDuration: 0.2, delay: 0, options: [], animations: {
                self.redCarImage.center.x = self.roadImage.frame.origin.x + self.roadImage.frame.width
            }) {(result) in
                self.navigateToGameOverView()
                self.isGameStarted = false
                self.rememberScoreValue()
                self.rememberRecordDate()
            }
            }
        }
    }
    
    func animateRoad(_ time: CGFloat) {
        if isGameStarted == true {
        UIImageView.animate(withDuration: TimeInterval(time), delay: 0, options:[.curveLinear], animations: {
            self.roadImage.frame.origin.y = self.roadImage.frame.size.height
            self.road2Image.frame.origin.y = 0
        }) { (result) in
            self.roadImage.frame.origin.y = self.initialRoad1
            self.road2Image.frame.origin.y = self.initialRoad2
            self.animateRoad(time)
            }
        }
    }
        
    func animateLeftTree(_ time: CGFloat) {
        if isGameStarted == true {
        let speed = ((self.roadImage.frame.size.height-self.leftTreeImage.frame.origin.y)*time)/self.roadImage.frame.size.height
        UIImageView.animate(withDuration: TimeInterval(speed), delay: 0, options: [.curveLinear], animations: {
                self.leftTreeImage.frame.origin.y = self.roadImage.frame.size.height + self.leftTreeImage.frame.size.height
            }) { (result) in
                self.leftTreeImage.frame.origin.y = 0 - self.leftTreeImage.frame.size.height
                self.animateLeftTree(time)
            }
        }
    }
    
    func animateRightTree(_ time: CGFloat) {
        if isGameStarted == true {
        let speed = ((self.roadImage.frame.size.height-self.rightTreeImage.frame.origin.y)*time)/self.roadImage.frame.size.height
        UIImageView.animate(withDuration: TimeInterval(speed), delay: 0, options: [.curveLinear], animations: {
            self.rightTreeImage.frame.origin.y =  self.roadImage.frame.size.height + self.rightTreeImage.frame.size.height
        }) { (result) in
            self.rightTreeImage.frame.origin.y = 0 - self.rightTreeImage.frame.size.height
            self.animateRightTree(time)
            }
        }
    }
    
    func animateLeftStone(_ time: CGFloat) {
        if isGameStarted == true {
        let speed = ((self.roadImage.frame.size.height - self.leftStoneImage.frame.origin.y) * time)/self.roadImage.frame.size.height
        UIImageView.animate(withDuration: TimeInterval(speed), delay: 0, options: [.curveLinear], animations: {
            self.leftStoneImage.frame.origin.y =  self.roadImage.frame.size.height + self.leftStoneImage.frame.size.height
        }) { (result) in
            self.leftStoneImage.frame.origin.y = 0 - self.leftTreeImage.frame.size.height
            self.animateLeftStone(time)
            }
        }
    }
    
    func animateBlueCar(_ duration: TimeInterval = 0.2) {
        if isGameStarted == true {
        UIImageView.animate(withDuration: duration, delay: 0, options: [.curveLinear], animations: {
            
            self.blueCarImage.frame.origin.y += self.view.frame.size.height/10
            
        }) { (_) in
            if self.blueCarImage.frame.origin.y > self.roadImage.frame.size.height {
            self.blueCarImage.frame.origin.y = 0 - self.blueCarImage.frame.size.height
                let carShouldBeRight = self.roadImage.center.x + self.roadImage.frame.size.width/4
                let carShouldBeLeft = self.roadImage.center.x - self.roadImage.frame.size.width/4
            self.blueCarImage.center.x = [carShouldBeRight, carShouldBeLeft].randomElement() ?? self.roadImage.center.x + self.roadImage.frame.size.width/4
                self.score += 1
                
                switch self.score {
                case 0...5:
                    self.animateBlueCar(duration)
                case 5...10:
                    self.animateBlueCar(0.17)
                case 10...15:
                    self.animateBlueCar(0.13)
                case 15...20:
                    self.animateBlueCar(0.1)
                case 20...100:
                    self.animateBlueCar(0.09)
                default:
                    print ("default")
                }
            }
            else {
                self.animateBlueCar(duration)
                }
            }
        }
    }
        
        func animateRedCar() {
            if isGameStarted == true {
            if redCarImage.frame.origin.y == self.view.frame.size.height + redCarImage.frame.size.height {
                UIImageView.animate(withDuration: 1, delay: 0, options: [], animations: {
                    self.redCarImage.frame.origin.y = self.view.frame.size.height - self.redCarImage.frame.size.height
                })
                }
            }
    }
    
    func navigateToGameOverView() {
        let gameOverStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let gameOverViewController = gameOverStoryboard.instantiateViewController(withIdentifier: String(describing: GameOverViewController.self)) as? GameOverViewController
        self.navigationController?.pushViewController(gameOverViewController ?? UIViewController(), animated: true)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.playCrushSound()
        self.carRidePlayer?.stop()
    }
    
    func selectCarImageAccordingToColor(){
        let carColor = UserDefaults.standard.value(forKey: .carColor) as? String
        if carColor == "Yellow" || carColor == "Желтая" {
            redCarImage.image = UIImage(named: "yellowCar")
        }
        else {
            redCarImage.image = UIImage(named: "redCar")
        }
    }
    
    func rememberScoreValue() {
        UserDefaults.standard.setValue(score, forKey: .score)
    }
    
    func rememberRecordDate() {
        let date = Date()
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateStyle = .medium
        
        let recordDate = formatter.string(from: date)
        UserDefaults.standard.setValue(recordDate, forKey: .date)
    }
    
    func playCarSound() {
        if isSoundNeeded == true {
        if let carSoundPath = Bundle.main.path(forResource: "carRideSound", ofType: "mp3") {
            let carSoundUrl = URL(fileURLWithPath: carSoundPath)
            do {
                carRidePlayer = try AVAudioPlayer(contentsOf: carSoundUrl)
            }
            catch {
                print(error.localizedDescription)
            }
            carRidePlayer?.play()
            carRidePlayer?.numberOfLoops = -1
            }
        }
    }
    
    func playCarTurnSound() {
        if isSoundNeeded == true {
        if let carTurnSoundPath = Bundle.main.path(forResource: "carTurnSound", ofType: "mp3") {
            let carTurnSoundUrl = URL(fileURLWithPath: carTurnSoundPath)
            do {
                carTurnPlayer = try AVAudioPlayer(contentsOf: carTurnSoundUrl)
            }
            catch {
                print(error.localizedDescription)
            }
            carTurnPlayer?.play()
            }
        }
    }
    
    func playCrushSound() {
        if isSoundNeeded == true {
        if let carCrushSoundPath = Bundle.main.path(forResource: "carCrushSound", ofType: "mp3") {
            let carCrushSoundUrl = URL(fileURLWithPath: carCrushSoundPath)
            do {
                carCrushPlayer = try AVAudioPlayer(contentsOf: carCrushSoundUrl)
            }
            catch {
                print (error.localizedDescription)
            }
            carCrushPlayer?.play()
            }
        }
    }
}
