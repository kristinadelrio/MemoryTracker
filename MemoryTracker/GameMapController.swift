//
//  GameMapController.swift
//  MemoryTracker
//
//  Created by Alejandro Del Rio Albrechet on 8/30/17.
//
//

import UIKit

class GameMapController: UIViewController {
    
    @IBOutlet weak var gameScene: UIView!
    
    var mapManager = MapManager()
    var openedCard: [CardView] = []
    let logic = GameLogic.shared
    
    var gameOver: (()->())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        logic.closeIfNeeded = { [weak self] in
            self?.closeCard()
        }
        
        logic.deleteCards = { [weak self] in
            self?.deleteCard()
        }
        
        putCards()
    }
    
    // Func for recognizing card
    func onCardTap(sender: UITapGestureRecognizer) {
        if let imageView = sender.view as? CardView,
            imageView.image == imageView.cardBack {
            
            if openedCard.count == 2 {
                logic.isCardSimilar(cardOne: openedCard[0], cardTwo: openedCard[1])
                
            }
            
            imageView.setCardFace()
            openedCard.append(imageView)
            isGameSceneEmpty()
        }
    }
    
    // closes opened card
    func closeCard() {
        openedCard[0].setCardBack()
        openedCard[1].setCardBack()
        
        openedCard = []
    }
    
    func deleteCard() {
        openedCard[0].removeFromSuperview()
        openedCard[1].removeFromSuperview()
        
        openedCard = []

    }
    
    func isGameSceneEmpty() {
        if gameScene.subviews.count == 2 {
            gameOver?()
        }
    }
    
    // Puts cards in the map
    func putCards(rawCount: Int = 5, columnCount: Int = 4) {
        var xPosition: CGFloat = 0
        var yPosition: CGFloat = 0
        
        for i in 0 ..< rawCount * columnCount {
            let rect = CGRect(x: xPosition,
                              y: yPosition,
                              width: gameScene.bounds.width / CGFloat(columnCount),
                              height: gameScene.bounds.height / CGFloat(rawCount))
            
            gameScene.addSubview(generateCard(with: rect, imageIndex: i))
            xPosition += gameScene.bounds.width / CGFloat(columnCount)
            
            if xPosition == gameScene.bounds.width {
                yPosition += gameScene.bounds.height /  CGFloat(rawCount)
                xPosition = 0
            }
        }
    }
    
    // Generate card inside rect with image face
    func generateCard(with rect: CGRect, imageIndex: Int) -> CardView {
        let card = CardView(frame: rect)
        
        card.cardFace = UIImage(named: "\(mapManager.imageName[imageIndex])")
        card.setCardBack()
        
        card.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onCardTap(sender:))))
        gameScene.addSubview(card)
        
        return card
    }
}
