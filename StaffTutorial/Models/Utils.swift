//
//  Utils.swift
//  StaffTutorial
//
//  Created by Casey Yost on 7/29/18.
//  Copyright © 2018 Casey Yost. All rights reserved.
//

import AVFoundation

var player: AVAudioPlayer?

func playSound(_ soundName: String) {
    
    let randValue = Int(arc4random_uniform(3))
    
    guard let url = Bundle.main.url(forResource: soundName + "_\(randValue)", withExtension: "mp3") else { return }
    
    do {
        try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
        try AVAudioSession.sharedInstance().setActive(true)
        
        /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
        player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
        
        /* iOS 10 and earlier require the following line:
         player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */
        
        guard let player = player else { return }
        
        player.play()
        
    } catch let error {
        print(error.localizedDescription)
    }
}
