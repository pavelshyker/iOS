//
//  ViewController.swift
//  Homework9_3_circleAppearWhereYouTap
//
//  Created by Pavel Shyker on 9/30/20.
//  Copyright © 2020 Pavel Shyker. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func startGameButtonTap(_ sender: Any) {
        
        let storyBoard = UIStoryboard (name: "Main", bundle: nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: String(describing: SecondViewController.self)) as! SecondViewController
        navigationController?.pushViewController(viewController, animated: true)
    }
    
}

