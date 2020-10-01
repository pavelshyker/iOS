//
//  SecondViewController.swift
//  Homework9_3_circleAppearWhereYouTap
//
//  Created by Pavel Shyker on 9/30/20.
//  Copyright © 2020 Pavel Shyker. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    var myView : UIView!
    
    var arrayView: [UIView] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
     
        let gesture = UITapGestureRecognizer()
        gesture.addTarget(self, action: #selector(processTap(_:)))
        view.addGestureRecognizer(gesture)
    }
    
    @objc func processTap (_ gesture: UITapGestureRecognizer){
        var location:CGPoint = gesture.location(in: view)
        
        myView = UIView()
        myView.frame.size = CGSize (width: 50, height: 50)
        myView.center = location

        
        var filteredArrayView = arrayView.filter({(($0.frame.origin.x...($0.frame.origin.x + myView.frame.width)).contains(location.x) && ($0.frame.origin.y...($0.frame.origin.y + myView.frame.height)).contains(location.y) )})
        
        
        if filteredArrayView.isEmpty
            {
            myView.backgroundColor = UIColor(red: CGFloat(Int.random(in: 0...255))/255, green: CGFloat(Int.random(in: 0...255))/255, blue: CGFloat(Int.random(in: 0...255))/255, alpha: 1)
            view.addSubview(myView)
            arrayView.append(myView)

            }
        else {
            filteredArrayView[0].removeFromSuperview()
            arrayView.remove(at: arrayView.firstIndex(of: filteredArrayView[0])!)
        }

        }
    }
    
    

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

