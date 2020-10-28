//
//  File.swift
//  Homework13_imagesSwipe
//
//  Created by Pavel Shyker on 10/18/20.
//  Copyright © 2020 Pavel Shyker. All rights reserved.
//

import UIKit

extension UIImageView {
    func setCornerRadius (_ value: CGFloat) {
        self.layer.cornerRadius = value
        self.layer.masksToBounds = true
    }
}
