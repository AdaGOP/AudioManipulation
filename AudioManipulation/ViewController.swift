//
//  ViewController.swift
//  AudioManipulation
//
//  Created by zein rezky chandra on 05/06/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var playButton: UIButton!
    
    @IBOutlet weak var plusSpeedButton: UIButton!
    @IBOutlet weak var speedProgress: UIProgressView!
    @IBOutlet weak var minusSpeedButton: UIButton!
    
    @IBOutlet weak var plusDistortButton: UIButton!
    @IBOutlet weak var distortProgress: UIProgressView!
    @IBOutlet weak var minusDistortButton: UIButton!
    
    @IBOutlet weak var plusReverbButton: UIButton!
    @IBOutlet weak var reverbProgress: UIProgressView!
    @IBOutlet weak var minusReverbButton: UIButton!
    
    @IBOutlet weak var delayProgress: UIProgressView!
    @IBOutlet weak var plusDelayButton: UIButton!
    @IBOutlet weak var minusDelayButton: UIButton!
    
    @IBOutlet weak var pitchProgress: UIProgressView!
    @IBOutlet weak var plusPitchButton: UIButton!
    @IBOutlet weak var minusPitchButton: UIButton!
    
    // Make sure we have the engine settle
    let audioEngine = AVAudioEngine()
    
    let audioPitch = AVAudioUnitTimePitch()
    let audioSpeed = AVAudioUnitVarispeed()
    let audioDistort = AVAudioUnitDistortion()
    let audioReverb = AVAudioUnitReverb()
    let audioDelay = AVAudioUnitDelay()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configAudioButton()
    }

}

// MARK: Audio Control Button
extension ViewController {
    
    // This is function to receive audio url, and ask audio engine to extract the file
    func play(_ url: URL) throws {
        // extract the audio file from given URL
        let file = try AVAudioFile(forReading: url)
        
        // Make sure we prepare the node
        let audioNode = AVAudioPlayerNode()
        
        // We need to tell the engine to connect all the component of node
        audioEngine.attach(audioNode)
        audioEngine.attach(audioPitch)
        audioEngine.attach(audioSpeed)
        audioEngine.attach(audioDistort)
        audioEngine.attach(audioReverb)
        audioEngine.attach(audioDelay)
        
        // we need to make sure our each unit audio component from audio property that we create such as speed, pitch, etc are not crash each other and creating a new chain of audio process.
        audioEngine.connect(audioNode, to: audioSpeed, format: nil)
        audioEngine.connect(audioSpeed, to: audioPitch, format: nil)
        audioEngine.connect(audioPitch, to: audioReverb, format: nil)
        audioEngine.connect(audioReverb, to: audioEngine.mainMixerNode, format: nil)
        
        //        audioEngine.connect(audioReverb, to: audioDistort, format: nil)
        //        audioEngine.connect(audioDistort, to: audioSpeed, format: nil)
        
        audioNode.scheduleFile(file, at: nil) // Last we need to prepare the player to play audio node sequentially from start to beginning based on the chain structure of our node.
        
        try audioEngine.start()
        audioNode.play()
    }
    
    func configAudioButton() {
        minusPitchButton.addTarget(self, action: #selector(minusPitch), for: .touchUpInside)
        plusPitchButton.addTarget(self, action: #selector(plusPitch), for: .touchUpInside)

        minusDelayButton.addTarget(self, action: #selector(minusDelay), for: .touchUpInside)
        plusDelayButton.addTarget(self, action: #selector(plusDelay), for: .touchUpInside)

        minusReverbButton.addTarget(self, action: #selector(minusReverb), for: .touchUpInside)
        plusReverbButton.addTarget(self, action: #selector(plusReverb), for: .touchUpInside)

        minusDistortButton.addTarget(self, action: #selector(minusDistort), for: .touchUpInside)
        plusDistortButton.addTarget(self, action: #selector(plusDistort), for: .touchUpInside)

        minusSpeedButton.addTarget(self, action: #selector(minusSpeed), for: .touchUpInside)
        plusSpeedButton.addTarget(self, action: #selector(plusSpeed), for: .touchUpInside)

        playButton.addTarget(self, action: #selector(playAction), for: .touchUpInside)
    }
    
    // Step 1, we need URL path of our resources
    @objc
    func playAction() {
        guard let url = Bundle.main.url(forResource: "psotmalone", withExtension: "mp3") else { return }
        do {
            try play(url)
        } catch let error {
            print(error.localizedDescription)
        }
    }

    
    @objc
    func minusPitch() {
        audioPitch.pitch -= 10
        DispatchQueue.main.async {
            self.pitchProgress.progress -= 0.1
        }
    }
    
    @objc
    func plusPitch() {
        audioPitch.pitch += 10
        DispatchQueue.main.async {
            self.pitchProgress.progress += 0.1
        }
    }
    
    @objc
    func minusSpeed() {
        audioSpeed.rate -= 0.1
        DispatchQueue.main.async {
            self.speedProgress.progress -= 0.1
        }
    }
    
    @objc
    func plusSpeed() {
        audioSpeed.rate += 0.1
        DispatchQueue.main.async {
            self.speedProgress.progress += 0.1
        }
    }
    
    @objc
    func minusDelay() {
        
    }
    
    @objc
    func plusDelay() {
        
    }
    
    @objc
    func minusReverb() {
        
    }
    
    @objc
    func plusReverb() {
        
    }
    
    @objc
    func minusDistort() {
        
    }
    
    @objc
    func plusDistort() {
        
    }
}
