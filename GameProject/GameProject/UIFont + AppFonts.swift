//
//  UIFont + AppFonts.swift
//  GameProject
//
//  Created by Pavel Shyker on 10/19/20.
//  Copyright © 2020 Pavel Shyker. All rights reserved.
//

import UIKit
extension UIFont {
    static func edgeRacer(ofSize: CGFloat) -> UIFont {
        return UIFont(name: "EdgeRacerHalftoneItalic", size: ofSize) ?? UIFont.systemFont(ofSize: ofSize)
    }
    
   static func airAmericana(ofSize: CGFloat) -> UIFont {
        return UIFont(name: "AirAmericana", size: ofSize) ?? UIFont.systemFont(ofSize: ofSize)
    }
}
