//
//  UIView + Shadow.swift
//  GameProject
//
//  Created by Pavel Shyker on 10/16/20.
//  Copyright © 2020 Pavel Shyker. All rights reserved.
//

import UIKit

extension UIView {
    func setShadow (color: CGColor = UIColor.black.cgColor,
                    offset: CGSize = CGSize (width: 5, height: -5),
                    opacity: Float = 1, radius: CGFloat = 5) {
        self.layer.shadowColor = color
        self.layer.shadowOffset = offset
        self.layer.shadowOpacity = opacity
        self.layer.shadowRadius = radius
    }
}
