//
//  ViewController.swift
//  Homework13_imagesSwipe
//
//  Created by Pavel Shyker on 10/18/20.
//  Copyright © 2020 Pavel Shyker. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageViewSecond: UIImageView!
    
    var imageArray = ["cat1", "cat2", "cat3", "cat4", "cat5"]
    var initPicNumber = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let image = UIImage(named: "\(imageArray[initPicNumber - 1])")
        let image2 = UIImage(named: "\(imageArray[initPicNumber])")
        
        imageView.image = image
        imageView.clipsToBounds = false
        imageView.contentMode = .scaleAspectFill
        imageView.setShadow(radus: 10, offset: CGSize(width: 5, height: -5), opacity: 1)
        
        imageViewSecond.image = image2
        imageViewSecond.clipsToBounds = false
        imageViewSecond.contentMode = .scaleAspectFill
        imageViewSecond.setShadow(radus: 10, offset: CGSize(width: 5, height: -5), opacity: 1)
        
        let rightSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(processSwipe(_:)))
        rightSwipeGesture.direction = .right
        view.addGestureRecognizer(rightSwipeGesture)
        
        let leftSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(processSwipe(_:)))
        leftSwipeGesture.direction = .left
        view.addGestureRecognizer(leftSwipeGesture)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        imageView.center = view.center
        imageViewSecond.center.x = view.center.x - view.frame.size.width
        imageViewSecond.center.y = view.center.y
    }
    
    @objc func processSwipe (_ swipeGesture: UISwipeGestureRecognizer) {
        switch swipeGesture.direction {
        case .right:
            if  imageView.center.x == view.center.x {
                imageViewSecond.center.x = view.center.x - view.frame.size.width
                imageViewSecond.image = UIImage(named: getNextImageName())
            }
            else {
                imageView.center.x = view.center.x - view.frame.size.width
                imageView.image = UIImage(named: getNextImageName())
            }
            animateRightSwipe()
        case .left:
            if  imageView.center.x == view.center.x {
                imageViewSecond.center.x = view.center.x + view.frame.size.width
                imageViewSecond.image = UIImage(named: getPreviousImageName())
                }
            else {
                self.imageView.center.x = self.view.center.x + self.view.frame.size.width
                imageView.image = UIImage(named: getPreviousImageName())
            }
            animateLeftSwipe()
        default:
            print ("default")
        }
    }
    
    //MARK: - animate and getting image name functions
    
    func getNextImageName() -> String {
        if initPicNumber < imageArray.count {
            initPicNumber += 1
        }
        else {
            initPicNumber = 1
        }
        return "\(imageArray[initPicNumber - 1])"
    }
    
    func getPreviousImageName() -> String {
        if initPicNumber > 1 {
            initPicNumber -= 1
        }
        else {
            initPicNumber = imageArray.count
        }
        return "\(imageArray[initPicNumber - 1])"
    }
    
    func animateRightSwipe(duration: TimeInterval = 1, delay: TimeInterval = 0.1) {
        UIImageView.animate(withDuration: duration, delay: delay, options: [], animations: {
            self.imageView.center.x = self.imageView.center.x + self.view.frame.size.width
            self.imageViewSecond.center.x = self.imageViewSecond.center.x + self.view.frame.size.width
        })
    }
    
    func animateLeftSwipe(duration: TimeInterval = 1, delay: TimeInterval = 0.1) {
        UIImageView.animate(withDuration: duration, delay: delay, options: [], animations: {
            self.imageView.center.x = self.imageView.center.x - self.view.frame.size.width
            self.imageViewSecond.center.x = self.imageViewSecond.center.x - self.view.frame.size.width
        })
    }
}
