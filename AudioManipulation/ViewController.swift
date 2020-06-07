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

    let audioEngine = AVAudioEngine() // we need an instance from audio engine to store the audio file.
    let audioSpeedControl = AVAudioUnitVarispeed() // we need an instance for property from audio engine that can control the audio speed  based on the audio node
    let audioPitchControl = AVAudioUnitTimePitch() // we need an instance for property from audio engine that can control the pitch based on the audio
    let distortion = AVAudioUnitDistortion()
    let reverb = AVAudioUnitReverb()
//    let audioBuffer = AVAudioPCMBuffer()
//    let outputFile = AVAudioFile()
    let delay = AVAudioUnitDelay()
    
    @IBOutlet weak var delayProgressLevel: UIProgressView!
    @IBOutlet weak var delayPlusButton: UIButton!
    @IBOutlet weak var delayMinusButton: UIButton!
    @IBOutlet weak var reverbProgressLevel: UIProgressView!
    @IBOutlet weak var reverbPlusButton: UIButton!
    @IBOutlet weak var reverbMinusButton: UIButton!
    @IBOutlet weak var distortionProgressLevel: UIProgressView!
    @IBOutlet weak var distortionPlusButton: UIButton!
    @IBOutlet weak var distortionMinusButton: UIButton!
    @IBOutlet weak var speedProgressLevel: UIProgressView!
    @IBOutlet weak var speedPlusButton: UIButton!
    @IBOutlet weak var speedMinusButton: UIButton!
    @IBOutlet weak var pitchProgressLevel: UIProgressView!
    @IBOutlet weak var pitchPlusButton: UIButton!
    @IBOutlet weak var pitchMinusButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configAudioButton()
    }

    @objc func playAudio() {
        guard let url = Bundle.main.url(forResource: "psotmalone", withExtension: "mp3") else { return } // We need load some mp3 sample file for us to play with the audio engine
        do {
            try play(url) // we need to share the URL path of our audio file
        } catch let error {
            print(error.localizedDescription)
        }
    }

    // Create audio file to be played
    func play(_ url: URL) throws {
        let file = try AVAudioFile(forReading: url) // extract the audio file from URL
        
        let audioPlayer = AVAudioPlayerNode() // We need to create an instance of audio node property from audio engine

        // We need to connect the components to our playback engine, such as the speed component and the pitch component, so our node property can recognize it and work with it.
        audioEngine.attach(audioPlayer)
        audioEngine.attach(audioPitchControl)
        audioEngine.attach(audioSpeedControl)
        audioEngine.attach(distortion)
        audioEngine.attach(reverb)
        audioEngine.attach(delay)

        // We need to make sure our each component from audio property that we create before such as speed and pitch are not crash each other. Remember concept of the audio is like having a port for input port, and output port, so if we want to play and manipulate the audio based on the node, we have to arrange the parts so that output from one is input to another
        audioEngine.connect(audioPlayer, to: audioSpeedControl, format: nil)
        audioEngine.connect(audioSpeedControl, to: audioPitchControl, format: nil)
        audioEngine.connect(audioPitchControl, to: reverb, format: nil)
//        audioEngine.connect(distortion, to: reverb, format: nil)
        audioEngine.connect(reverb, to: audioEngine.mainMixerNode, format: nil)
//        audioEngine.connect(delay, to: audioEngine.mainMixerNode, format: nil)

        
        audioPlayer.scheduleFile(file, at: nil) // Last we need to prepare the player to play audio sequencially start from beginning to end

        try audioEngine.start() // Start the engine
        audioPlayer.play()
    }
    
}


// MARK: Audio Control Button
extension ViewController {
    func configAudioButton() {
        playButton.addTarget(self, action: #selector(playAudio), for: .touchUpInside)
        pitchMinusButton.addTarget(self, action: #selector(pitchMinusAction), for: .touchUpInside)
        pitchPlusButton.addTarget(self, action: #selector(pitchPlusAction), for: .touchUpInside)
        speedMinusButton.addTarget(self, action: #selector(speedMinusAction), for: .touchUpInside)
        speedPlusButton.addTarget(self, action: #selector(speedPlusAction), for: .touchUpInside)
        distortionMinusButton.addTarget(self, action: #selector(distortMinusAction), for: .touchUpInside)
        distortionPlusButton.addTarget(self, action: #selector(distortPlusAction), for: .touchUpInside)
        reverbMinusButton.addTarget(self, action: #selector(reverbMinusAction), for: .touchUpInside)
        reverbPlusButton.addTarget(self, action: #selector(reverbPlusAction), for: .touchUpInside)
        delayMinusButton.addTarget(self, action: #selector(delayMinusAction), for: .touchUpInside)
        delayPlusButton.addTarget(self, action: #selector(delayPlusAction), for: .touchUpInside)
    }
    
    @objc
    func pitchMinusAction() {
        audioPitchControl.pitch -= 10
        DispatchQueue.main.async {
            self.pitchProgressLevel.progress -= 0.1
        }
    }
    
    @objc
    func pitchPlusAction() {
        audioPitchControl.pitch += 10
        DispatchQueue.main.async {
            self.pitchProgressLevel.progress += 0.1
        }
    }
    
    @objc
    func speedMinusAction() {
        audioSpeedControl.rate -= 0.1
        DispatchQueue.main.async {
            self.speedProgressLevel.progress -= 0.1
        }
    }
    
    @objc
    func speedPlusAction() {
        audioSpeedControl.rate += 0.1
        DispatchQueue.main.async {
            self.speedProgressLevel.progress += 0.1
        }
    }
    
    @objc
    func distortMinusAction() {
        distortion.wetDryMix -= 50
        DispatchQueue.main.async {
            self.distortionProgressLevel.progress -= 0.1
        }
    }
    
    @objc
    func distortPlusAction() {
        distortion.wetDryMix += 50
        DispatchQueue.main.async {
            self.distortionProgressLevel.progress += 0.1
        }
    }
    
    @objc
    func reverbMinusAction() {
        reverb.wetDryMix -= 50
        DispatchQueue.main.async {
            self.reverbProgressLevel.progress -= 0.1
        }
    }
    
    @objc
    func reverbPlusAction() {
        reverb.wetDryMix += 50
        DispatchQueue.main.async {
            self.reverbProgressLevel.progress += 0.1
        }
    }
    
    @objc
    func delayMinusAction() {
        delay.feedback -= 50
        DispatchQueue.main.async {
            self.delayProgressLevel.progress -= 0.1
        }
    }
    
    @objc
    func delayPlusAction() {
        delay.feedback += 50
        DispatchQueue.main.async {
            self.delayProgressLevel.progress += 0.1
        }
    }
}
