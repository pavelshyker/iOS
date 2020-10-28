//
//  UsersDeafault + Keys.swift
//  GameProject
//
//  Created by Pavel Shyker on 10/26/20.
//  Copyright © 2020 Pavel Shyker. All rights reserved.
//

import Foundation

extension UserDefaults {
    func setValue(_ value: Any?, forKey key: UserDefaultKeys) {
        setValue(value, forKey: key.rawValue)
    }
    
    func value(forKey key: UserDefaultKeys) -> String {
        return value(forKey: key.rawValue) as? String ?? ""
    }
    
}
