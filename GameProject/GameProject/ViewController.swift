//
//  ViewController.swift
//  GameProject
//
//  Created by Pavel Shyker on 9/28/20.
//  Copyright © 2020 Pavel Shyker. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var titleTextLabel: UILabel!
    
    @IBOutlet weak var startScreenImage: UIImageView!
    
    @IBOutlet weak var newGameButton: UIButton!
    @IBOutlet weak var recordsButton: UIButton!
    @IBOutlet weak var settingsButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let text = "Car is on Fire!"
        let attributedText = NSMutableAttributedString(string: text)
        let wholeRange = (text as NSString).range(of: text)
        attributedText.addAttribute(.font, value: UIFont.edgeRacer(ofSize: 40), range: wholeRange)
        titleTextLabel.attributedText = attributedText
      
        newGameButton.titleLabel?.font = UIFont.airAmericana(ofSize: 27)
        recordsButton.titleLabel?.font = UIFont.airAmericana(ofSize: 27)
        settingsButton.titleLabel?.font = UIFont.airAmericana(ofSize: 27)
        
        let backButton = UIBarButtonItem()
        backButton.title = "Back to menu"
        navigationItem.backBarButtonItem = backButton
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //navigationController?.setNavigationBarHidden(false, animated: animated)
        
        newGameButton.setCornerRadius(radius: newGameButton.frame.height/2)
        newGameButton.setShadow(opacity: 0.7, radius: 5)
        
        recordsButton.setCornerRadius(radius: recordsButton.frame.height/2)
        recordsButton.setShadow(opacity: 0.7, radius: 5)
        
        settingsButton.setCornerRadius(radius: settingsButton.frame.height/2)
        settingsButton.setShadow(opacity: 0.7, radius: 5)
    }

    
    @IBAction func newGameButtonTap(_ sender: Any) {
        let gameStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        let gameViewController = gameStoryBoard.instantiateViewController(withIdentifier: String(describing: GameViewController.self)) as? GameViewController
        navigationController?.pushViewController(gameViewController ?? UIViewController(), animated: true)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    @IBAction func recordsTableButtonTap(_ sender: Any) {
        let recordsStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        let recordsViewController = recordsStoryBoard.instantiateViewController(withIdentifier: String(describing: RecordsViewController.self)) as? RecordsViewController
        navigationController?.pushViewController(recordsViewController ?? UIViewController(), animated: true)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
   
    
    @IBAction func settingsButtonTap(_ sender: Any) {
        let settingsStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        let settingsViewController = settingsStoryBoard.instantiateViewController(withIdentifier: String(describing: SettingsViewController.self)) as? SettingsViewController
        navigationController?.pushViewController(settingsViewController ?? UIViewController(), animated: true)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
}

