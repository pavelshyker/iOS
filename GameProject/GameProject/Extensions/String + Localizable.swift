//
//  String + Localizable.swift
//  GameProject
//
//  Created by Pavel Shyker on 12/13/20.
//  Copyright © 2020 Pavel Shyker. All rights reserved.
//

import Foundation

extension String {
    func localized() -> String {
        return NSLocalizedString(self, comment: "")
    }
}
