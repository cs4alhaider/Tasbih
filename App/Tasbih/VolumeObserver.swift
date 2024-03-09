//
//  VolumeObserver.swift
//  Tasbih
//
//  Created by Abdullah Alhaider on 10/03/2024.
//

import Foundation
import AVFoundation
import MediaPlayer
import Observation

@Observable
class VolumeObserver: NSObject {
    var hit: Date = .now
    
    private var audioSession = AVAudioSession.sharedInstance()
    private let volumView = MPVolumeView()
    
    override init() {
        super.init()
        setupVolumeButtonHandling()
    }
    
    private func setupVolumeButtonHandling() {
        do {
            try audioSession.setActive(true)
        } catch {
            print("Failed to set up audio session.")
        }
        
        volumView.isHidden = true
        
        // Set an initial volume level if it's at zero
        if audioSession.outputVolume == 0 {
            volumView.setVolume(0.5)
        }
        
        audioSession.addObserver(self, forKeyPath: "outputVolume", options: [.new], context: nil)
    }
    
    deinit {
        audioSession.removeObserver(self, forKeyPath: "outputVolume")
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        volumView.setVolume(0.5)
        if keyPath == "outputVolume" && audioSession.outputVolume != 0.5 {
            DispatchQueue.main.async {
                self.hitIt()
            }
        }
    }
    
    func hitIt() {
        hit = .now
        triggerHapticFeedback()
    }
    
    func triggerHapticFeedback() {
        let feedbackGenerator = UIImpactFeedbackGenerator(style: .light)
        feedbackGenerator.impactOccurred()
    }
}

extension MPVolumeView {
    func setVolume(_ volume: Float) {
        let slider = subviews.first(where: { $0 is UISlider }) as? UISlider
        
        DispatchQueue.main.async {
            slider?.value = volume
        }
    }
}
