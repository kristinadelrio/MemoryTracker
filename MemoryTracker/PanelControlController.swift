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
    var timeOver: (()->())?
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    // Value that manage time and pause
    var timer = Timer()
    var isTimerRunning = false
    var isPause: Bool = false
    
    var timeConstraints = 60.0
 
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        runTimer()
    }
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1,
                                     target: self,
                                     selector: (#selector(presentTimer)),
                                     userInfo: nil,
                                     repeats: true)
        isTimerRunning = true
    }
    
    // updates timer and shows in label
    func presentTimer() {
        if timeConstraints < 1 {
            timer.invalidate()
            timeOver?()
        } else {
            timeConstraints -= 1
            timeLabel.text = TimeInterval.toString(timeConstraints)
        }
    }

    // Shows current score in label
    func present(score: Double) {
        scoreLabel.text = "\(score)"
    }
    
    // Sends event that pause taped
    @IBAction func pauseTap(_ sender: UIButton) {
        if isPause == false {
            timer.invalidate()
            isTimerRunning = false
            isPause = true
            
        } else {
            runTimer()
            isTimerRunning = true
            isPause = false
        }
        
        onPauseTap?(isPause)
    }
    
    // Sends event that home taped
    @IBAction func homeTap(_ sender: UIButton) {
        onHomeTap?()
    }
}

