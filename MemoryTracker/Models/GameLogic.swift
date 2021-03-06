//
//  GameLogic.swift
//  MemoryTracker
//
//  Created by Alejandro Del Rio Albrechet on 8/31/17.
//
//

import Foundation

class GameLogic {
    
    static var shared = GameLogic()
    
    // Works with game map
    var closeIfNeeded: (()->())?
    var deleteCards: (()->())?
    
    // Works with control panel
    var presentScore: ((Double)->())?

    var score = 0.0
    var totalScore = 0.0
    
    var timeLimit = 60.0
    var currentTime = 60.0
    
    func setTimeLimit(time: Double) {
        currentTime = time
        timeLimit = time
    }
    
    // Checks if card similar
    func isCardSimilar(cardOne: CardView, cardTwo: CardView) {
        if cardOne.image == cardTwo.image {
            score += 25
            deleteCards?()
        } else {
            score -= 5
            closeIfNeeded?()
        }
        
        updateScore()
    }
    
    // Sends current score
    func updateScore() {
        totalScore = score * 100 * currentTime / timeLimit
        presentScore?(totalScore)
    }
}
