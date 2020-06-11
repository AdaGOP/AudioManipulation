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
        guard let url = Bundle.main.url(forResource: "psotmalone", withExtension: "mp3") else { return } // load some mp3 sample file for us to play with the audio engine
        do {
            try play(url) // share the URL path of our audio file
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func play(_ url : URL) throws {
        //need to extract the audio file from URL
        let file = try AVAudioFile(forReading: url)
        
        //create an instance of audio node property from audio engine
        let audioNode = AVAudioPlayerNode()
        
        audioEngine.attach(audioNode)
        audioEngine.attach(audioPitch)
        audioEngine.attach(audioSpeed)
        audioEngine.attach(audioDelay)
        audioEngine.attach(audioDistort)
        audioEngine.attach(audioReverb)
        
        //asrrange the parts so that ouput from one is input to another
        audioEngine.connect(audioNode, to: audioSpeed, format: nil)
        audioEngine.connect(audioSpeed, to: audioPitch, format: nil)
        audioEngine.connect(audioPitch, to: audioReverb, format: nil)
        audioEngine.connect(audioReverb, to: audioEngine.mainMixerNode, format: nil)
//        audioEngine.connect(audioDistort, to: audioSpeed, format: nil)
//        audioEngine.connect(audioSpeed, to: audioEngine.mainMixerNode, format: nil)
        
        audioNode.scheduleFile(file, at: nil) // play audio sequencially start from beginning to end
        
        try audioEngine.start() // start the engine
        audioNode.play()
        
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
        audioDelay.feedback -= 50
        DispatchQueue.main.async {
            self.delayProgress.progress -= 0.1
        }
    }
    
    @objc
    func plusDelay() {
        audioDelay.feedback += 50
        DispatchQueue.main.async {
            self.delayProgress.progress += 0.1
        }
    }
    
    @objc
    func minusReverb() {
        audioReverb.wetDryMix -= 50
        DispatchQueue.main.async {
            self.reverbProgress.progress -= 0.1
        }
    }
    
    @objc
    func plusReverb() {
        audioReverb.wetDryMix += 50
        DispatchQueue.main.async {
            self.reverbProgress.progress += 0.1
        }
    }
    
    @objc
    func minusDistort() {
        audioDistort.wetDryMix -= 50
        DispatchQueue.main.async {
            self.distortProgress.progress -= 0.1
        }
    }
    
    @objc
    func plusDistort() {
        audioDistort.wetDryMix += 50
        DispatchQueue.main.async {
            self.distortProgress.progress += 0.1
        }
    }
}
