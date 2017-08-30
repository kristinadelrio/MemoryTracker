//
//  PanelControlController.swift
//  MemoryTracker
//
//  Created by Alejandro Del Rio Albrechet on 8/30/17.
//
//

import UIKit

class PanelControlController: UIViewController {

    var onPauseTap: ((Bool)->())?
    var onHomeTap: (()->())?
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    var isPause: Bool = false
    
    // Shows current time usage in label
    func present(time: Timer) {
        timeLabel.text = "\(time)"
    }
    
    // Shows current score in label
    func present(score: Double) {
        scoreLabel.text = "\(score)"
    }
    
    // Sends event that pause taped
    @IBAction func pauseTap(_ sender: UIButton) {
        isPause = isPause == false ? true : false
        onPauseTap?(isPause)
    }
    
    // Sends event that home taped
    @IBAction func homeTap(_ sender: UIButton) {
        onHomeTap?()
    }
}
