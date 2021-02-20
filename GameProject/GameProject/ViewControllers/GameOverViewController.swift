//
//  GameOverViewController.swift
//  GameProjectUITests
//
//  Created by Pavel Shyker on 10/27/20.
//  Copyright © 2020 Pavel Shyker. All rights reserved.
//

import UIKit
import AVKit

class GameOverViewController: UIViewController {

    var name: String = "Player"
    var date: String = ""
    var score: Int = 0
    var recordResult: Result = Result()
    var resultsArray = [Result]()
    var gameOverPlayer: AVAudioPlayer?
    var isSoundNeeded: Bool = true

    @IBOutlet weak var gameOverImageView: UIImageView!
    @IBOutlet weak var resultsScoreLabel: UILabel!
    @IBOutlet weak var backToMenuButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        name = UserDefaults.standard.value(forKey: .userName) as? String ?? "Player"
        date = UserDefaults.standard.value(forKey: .date) as? String ?? "Unknown date"
        
        if let data = UserDefaults.standard.value(forKey: "recordResult") as? Data {
            do {
                let recordResult = try JSONDecoder().decode([Result].self, from: data)
                self.resultsArray = recordResult
            }
            catch {
                print (error.localizedDescription)
                resultsArray = []
            }
        }
        else {
            resultsArray = []
        }
        isSoundNeeded = UserDefaults.standard.value(forKey: .sound) as? Bool ?? true
        
        gameOverImageView.alpha = 0
        score = UserDefaults.standard.value(forKey: .score) as? Int ?? 0
        resultsScoreLabel.text = "\(score)"
        backToMenuButton.setCornerRadius(radius: backToMenuButton.frame.size.height/2)
        backToMenuButton.setShadow(opacity: 0.7, radius: 5)
        rememberRecord()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        animateGameOverImage()
        playGameOverTheme()
    }
    
    func animateGameOverImage() {
        UIImageView.animate(withDuration: 1.5, delay: 0, animations: {
            self.gameOverImageView.alpha = 1
        }) {(_) in
            UIImageView.animate(withDuration: 1.5, delay: 0, animations: {
                self.gameOverImageView.alpha = 0
            }) {(_) in self.animateGameOverImage()
            }
        }
    }
    
    @IBAction func backToMenuButtonTapped(_ sender: Any) {
        gameOverPlayer?.stop()
        UserDefaults.standard.setValue(true, forKey: .soundRestart)
        navigationController?.popToRootViewController(animated: true)
    }
    
    func rememberRecord() {
        recordResult = Result(name: name, score: score, date: date)
        if resultsArray.count < 10 {
        resultsArray.append(recordResult)
        }
        else {
            resultsArray.append(recordResult)
            resultsArray.sort { $0.scoreRecord < $1.scoreRecord }
            resultsArray.remove(at: 0)
        }
        do {
            let data = try JSONEncoder().encode(resultsArray)
            UserDefaults.standard.setValue(data, forKey: .record)
        }
        catch {
            print (error.localizedDescription)
        }
    }
    
    func playGameOverTheme() {
        if isSoundNeeded == true {
        if let carWaitingSoundPath = Bundle.main.path(forResource: "carWaitingSound", ofType: "mp3") {
            let carWaitingSoundUrl = URL(fileURLWithPath: carWaitingSoundPath)
            do {
                gameOverPlayer = try AVAudioPlayer(contentsOf: carWaitingSoundUrl)
            }
            catch {
                print(error.localizedDescription)
            }
            gameOverPlayer?.play()
            gameOverPlayer?.numberOfLoops = -1
            }
        }
    }
}
