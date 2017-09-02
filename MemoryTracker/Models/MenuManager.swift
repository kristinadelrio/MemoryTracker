//
//  MenuManager.swift
//  MemoryTracker
//
//  Created by Alejandro Del Rio Albrechet on 8/31/17.
//
//

import Foundation

class MenuMeneger {
    
    let soundManager: SoundManager
    
    enum MenuState: String {
        case level = "levelIndex"
    }

    init() {
        soundManager = SoundManager()
        
        // In first launch app value will be nil
        if UserDefaults.standard.value(forKey: MenuState.level.rawValue) as? Int == nil {
            UserDefaults.standard.set(0, forKey: MenuState.level.rawValue)
        }
    }
    
    
    // Work with user defaults for getting and setting level index
    var levelIndex: Int {
        get {
            return  UserDefaults.standard.value(forKey: MenuState.level.rawValue) as? Int ?? 0
        }
        set {
            UserDefaults.standard.set(newValue, forKey: MenuState.level.rawValue)
        }
    }
    
    // Transfer new value to sound manager property
    var soundState: Bool {
        get {
            return soundManager.soundState
        }
        set {
            soundManager.soundState = newValue
        }
    }
    
}
