//
//  ViewController.swift
//  HomewWork11_Animation
//
//  Created by Pavel Shyker on 10/5/20.
//  Copyright © 2020 Pavel Shyker. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    enum Diractions {
        case up
        case down
    }
    
    @IBOutlet weak var redView: UIView!
    @IBOutlet weak var yellowView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        yellowView.frame.size = CGSize(width: 250, height: 400)
        redView.frame.size = CGSize(width: 50, height: 50)
       
        view.addSubview(yellowView)

        yellowView.addSubview(redView)
        yellowView.center = view.center
        
        redView.center.x = yellowView.frame.size.width/2
        redView.center.y = yellowView.frame.size.height/2
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        redView.layer.cornerRadius = redView.frame.size.width/2
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    

    @IBAction func animateButtonTap(_ sender: Any) {
        animateCircle (direction: .up)
        
        {
            self.animateCircle (direction: .down)
            {
                    self.animateButtonTap(sender)
                }
        }
    }
    
    
    func animateCircle (direction: Diractions, completion: @escaping () -> ())
    {
        UIView.animate(withDuration: 2, delay: 0, options: [.curveLinear], animations: {
        
            switch direction {
            case .up:
            self.redView.center.x = self.yellowView.frame.size.width/2
        self.redView.frame.origin.y = 0
            case .down:
            self.redView.center.x = self.yellowView.frame.size.width/2
                self.redView.frame.origin.y = self.yellowView.frame.size.height - self.redView.frame.height
            }
    }) {(_) in
    completion()
    }
}
    
}



/*@IBAction func animateButtonTap(_ sender: Any) {
    UIView.animate(withDuration: 2, delay: 0, options: [.curveLinear], animations: {
        self.redView.center.x = self.yellowView.frame.size.width/2
        self.redView.frame.origin.y = 0
    }) {(result) in
        self.redView.center.x = self.yellowView.frame.size.width/2
        self.redView.frame.origin.y = self.yellowView.frame.size.height - self.redView.frame.height
        print ("done")
    }
}*/

