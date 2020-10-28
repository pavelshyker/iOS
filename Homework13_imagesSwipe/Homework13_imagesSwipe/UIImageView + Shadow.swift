//
//  UIImageView + Shadow.swift
//  Homework13_imagesSwipe
//
//  Created by Pavel Shyker on 10/18/20.
//  Copyright © 2020 Pavel Shyker. All rights reserved.
//

import UIKit

extension UIImageView {
    func setShadow (color: CGColor = UIColor.black.cgColor,
                    radus: CGFloat = 15,
                    offset: CGSize = CGSize(width: 5, height: 5),
                    opacity: Float = 0.5) {
        self.layer.shadowColor = color
        self.layer.shadowRadius = radus
        self.layer.shadowOffset = offset
        self.layer.shadowOpacity = opacity
    }
}
