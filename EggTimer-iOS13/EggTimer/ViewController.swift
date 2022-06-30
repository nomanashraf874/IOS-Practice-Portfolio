//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    var player: AVAudioPlayer?
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var titleLabel: UILabel!
    var time = ["Soft":5 , "Medium":7 , "Hard":13]
    var timer = Timer()
    @IBAction func hardness(_ sender: UIButton) {
        progressBar.progress = 0.0
        timer.invalidate()
        let hardness = sender.currentTitle!
        if(time[hardness] != nil)
        {
            let secondsOriginal = time[hardness]!
            var secondsRemaining = time[hardness]!
            self.titleLabel.text = hardness
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (Timer) in
                self.progressBar.progress = self.progressBar.progress + (1.0/Float(secondsOriginal))
                if secondsRemaining > 0 {
                    secondsRemaining -= 1
                } else {
                    self.playSound()
                    self.titleLabel.text="DONE!"
                    Timer.invalidate()
                }
            }
        }
            
    }
    func playSound() {
        guard let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3") else { return }

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
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
}
