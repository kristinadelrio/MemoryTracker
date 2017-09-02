//
//  GameOverView.swift
//  MemoryTracker
//
//  Created by Alejandro Del Rio Albrechet on 9/1/17.
//
//

import UIKit

class GameOverView: UIView {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var gameOverLabel: UILabel!
    @IBOutlet weak var repeatButton: UIButton!
    
    var onRepeatButtTap: (()->())?

    @IBAction func onRepeatTap(_ sender: UIButton) {
        onRepeatButtTap?()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("GameOverView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
}
