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

    }

    
    @objc
    func minusPitch() {

    }
    
    @objc
    func plusPitch() {

    }
    
    @objc
    func minusSpeed() {

    }
    
    @objc
    func plusSpeed() {

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
