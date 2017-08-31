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
    
    var closeIfNeeded: (()->())?
    var deleteCards: (()->())?
    
    var presentScore: ((Int)->())?
    var score: Int = 0
    
    func isCardSimilar(cardOne: CardView, cardTwo: CardView) {
        if cardOne.image == cardTwo.image {
            score += 25
            updateScore()
            deleteCards?()
        } else {
            closeIfNeeded?()
        }
    }
    
    func updateScore() {
        presentScore?(score)
    }
    
    
    /*
     when add sdore 
     timer
     */
}
