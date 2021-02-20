//
//  RecordResult.swift
//  GameProject
//
//  Created by Pavel Shyker on 10/29/20.
//  Copyright © 2020 Pavel Shyker. All rights reserved.
//

import Foundation

class Result: Codable {
    var userName: String
    var scoreRecord: Int
    var recordDate: String
    
    init(name: String = "Player", score: Int = 0, date: String = "") {
        self.userName = name
        self.scoreRecord = score
        self.recordDate = date
    }
}
