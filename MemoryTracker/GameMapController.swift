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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        putCards()
    }
    
    func onCardTap(sender: UITapGestureRecognizer) {
        if let imageView = sender.view as? CardView {
            if imageView.image == imageView.cardBack {
                imageView.setCardFace()
            } else {
                imageView.setCardBack()
            }
        }
    }
    
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
    
    func generateCard(with rect: CGRect, imageIndex: Int) -> CardView {
        let card = CardView(frame: rect)
        
        card.cardFace = UIImage(named: "\(mapManager.imageName[imageIndex])")
        card.setCardBack()
        
        card.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onCardTap(sender:))))
        gameScene.addSubview(card)
        
        return card
    }
}
