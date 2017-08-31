//
//  ViewController.swift
//  MemoryTracker
//
//  Created by Alejandro Del Rio Albrechet on 8/30/17.
//
//

import UIKit

class MenuController: UIViewController {
    
    @IBOutlet weak var levelControl: UISegmentedControl!
    @IBOutlet weak var soundButton: UIButton!
    
    var menuManager: MenuMeneger!
    
    @IBAction func changeSoundState(_ sender: UIButton) {
        menuManager.soundState = !menuManager.soundState
        set(soundState: menuManager.soundState)
    }
    
    @IBAction func levelChanged(_ sender: UISegmentedControl) {
        menuManager.levelIndex = sender.selectedSegmentIndex
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuManager = MenuMeneger()
        
        set(levelIndex: menuManager.levelIndex)
        set(soundState: menuManager.soundState)
    }
    
    func set(soundState: Bool) {
        if soundState {
            soundButton.setImage(#imageLiteral(resourceName: "speakerOn"), for: .normal)
            menuManager.soundManager.playMusic()
            
        } else {
            soundButton.setImage(#imageLiteral(resourceName: "speakerOff"), for: .normal)
            menuManager.soundManager.stopMusic()
        }
    }
    
    func set(levelIndex: Int) {
        levelControl.selectedSegmentIndex = levelIndex
    }
}

