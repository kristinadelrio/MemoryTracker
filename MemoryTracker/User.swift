//
//  User.swift
//  MemoryTracker
//
//  Created by Alejandro Del Rio Albrechet on 8/31/17.
//
//

import Foundation

class UserScore: NSObject, NSCoding {
    
    enum Key: String {
        case username = "username"
        case score = "score"
        case date = "date"
    }
    
    var username: String?
    var score: Int?
    var date = Date()
    
    init(username: String, score: Int) {
        super.init()
        
        self.username = username
        self.score = score

    }
    
    required init?(coder aDecoder: NSCoder) {
        username = aDecoder.decodeObject(forKey: Key.username.rawValue) as? String
        score = aDecoder.decodeInteger(forKey: Key.score.rawValue)
        date = aDecoder.decodeObject(forKey: Key.date.rawValue) as? Date ?? Date()
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(username, forKey: Key.username.rawValue)
        aCoder.encode(score, forKey: Key.score.rawValue)
        aCoder.encode(date, forKey: Key.date.rawValue)
    }
}
