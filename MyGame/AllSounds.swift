//
//  AllSounds.swift
//  MyGame
//
//  Created by Sajan Shah on 9/19/20.
//  Copyright © 2020 Sajan Shah. All rights reserved.
//

import Foundation
import AVFoundation

class AllSounds {
    
    var audio:AVAudioPlayer?
    
    enum Sounds {
        case flip
        case correct
        case wrong
        case shuffle
    }
    
    func play (sound:Sounds) {
        
        var soundName = ""
        
        switch sound {
        
        case .flip:
            soundName = "cardflip"
        case .correct:
            soundName = "correctSound"
        case .wrong:
            soundName = "incorrectSound"
        case .shuffle:
            soundName = "shuffle"
        }
        
        let bundle = Bundle.main.path(forResource: soundName, ofType: ".wav")
        
        guard bundle != nil else {
            return
        }
        
        let url = URL(fileURLWithPath: bundle!)
        
        do {
            audio =  try AVAudioPlayer(contentsOf: url)
            
            audio?.play()
        }
        catch {
            print("Couldn't create an audio player")
            return
        }
    }
}
