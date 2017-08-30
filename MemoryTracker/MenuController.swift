//
//  ViewController.swift
//  MemoryTracker
//
//  Created by Alejandro Del Rio Albrechet on 8/30/17.
//
//

import UIKit
import AVFoundation

class MenuController: UIViewController {
    
    @IBOutlet weak var levelControl: UISegmentedControl!
    @IBOutlet weak var soundButton: UIButton!
    var audioPlayer = AVAudioPlayer()
    
    @IBAction func changeSoundState(_ sender: UIButton) {
        setSoundIfNeeded()
    }

    @IBAction func levelChanged(_ sender: UISegmentedControl) {
        UserDefaults.standard.set(sender.selectedSegmentIndex, forKey: "levelIndex")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setElementsDefaultsIfNeeded()
        setLevelOnControl()
        initMelody()
        setSoundIfNeeded()
    }
    
    func setElementsDefaultsIfNeeded() {
        if UserDefaults.standard.value(forKey: "soundState") as? Bool == nil {
            UserDefaults.standard.set(false, forKey: "soundState")
        }
        
        if UserDefaults.standard.value(forKey: "levelIndex") as? Int == nil {
            UserDefaults.standard.set(0, forKey: "levelIndex")
        }
    }
    
    func setLevelOnControl() {
        if let val = UserDefaults.standard.value(forKey: "levelIndex") as? Int {
            levelControl.selectedSegmentIndex = val
        }
    }
    
    func setSoundIfNeeded() {
        if let soundState = UserDefaults.standard.value(forKey: "soundState") as? Bool {
            if soundState != true {
                soundButton.setImage(#imageLiteral(resourceName: "speakerOn"), for: .normal)
                //audioPlayer.play()
                
            } else {
                soundButton.setImage(#imageLiteral(resourceName: "speakerOff"), for: .normal)
                //audioPlayer.stop()
            }
            
            UserDefaults.standard.set(!soundState, forKey: "soundState")
        }
    }
    
    func initMelody() {
        do {
            if let musicFile = Bundle.main.path(forResource: "opening", ofType: "mp3") {
                audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: musicFile))
            }
            
        } catch {
            print(error)
        }
    }
}

