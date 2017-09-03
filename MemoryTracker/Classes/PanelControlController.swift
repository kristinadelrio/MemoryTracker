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
    var onRestartTap: (()->())?
    var timeOver: (()->())?
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    var timer = Timer()
    var isTimerRunning = false
    var isPause: Bool = false
    var logic = GameLogic.shared
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        runTimer()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stopTimer()
    }
    
    // Sends event that taped on restart
    @IBAction func restartGame(_ sender: UIButton) {
        onRestartTap?()
    }
    
    // Sends event that pause taped
    @IBAction func pauseTap(_ sender: UIButton) {
        isPause = !isPause
        changeTimerState()
        onPauseTap?(isPause)
    }

    // Sends event that home taped
    @IBAction func homeTap(_ sender: UIButton) {
        onHomeTap?()
    }
    
    // Shows current score in label
    func present(score: Double) {
        scoreLabel.text = "\(round(score))"
    }
    
    // Starting running timer
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1,
                                     target: self,
                                     selector: (#selector(presentTimer)),
                                     userInfo: nil,
                                     repeats: true)
        isTimerRunning = true
    }

    // Methods for timer invalidation
    func stopTimer() {
        timer.invalidate()
        isTimerRunning = false
    }
    
    // Stop timer if it's running now and pause's switched on
    func changeTimerState() {
        isTimerRunning && isPause ? stopTimer() : runTimer()
    }
    
    // Updates timer and shows in label
    func presentTimer() {
        if logic.currentTime < 1 {
            timer.invalidate()
            timeOver?()
        } else {
            logic.currentTime -= 1
            timeLabel.text = TimeInterval.toString(logic.currentTime)
        }
    }
}

