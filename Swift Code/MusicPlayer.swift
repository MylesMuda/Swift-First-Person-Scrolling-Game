//
//  MusicPlayer.swift
//  16004388
//
//  Created by mm16aft on 07/01/2019.
//  Copyright © 2019 mm16aft. All rights reserved.
//

import AVFoundation

class GameMusicPlayer {
    static let musicPlayer = GameMusicPlayer()
    var audio: AVAudioPlayer?
    
    func playGameMusic() {
        let sound = NSURL(fileURLWithPath: Bundle.main.path(forResource: "moon", ofType: "mp3")!)
        do {
            audio = try AVAudioPlayer(contentsOf: sound as URL)
            audio!.numberOfLoops = -1
            audio!.prepareToPlay()
            audio!.play()
        }
        catch {
            print("Can not play music.")
        }
    }
}
