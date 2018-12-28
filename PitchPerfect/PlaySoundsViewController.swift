//
//  PlaySoundsViewController.swift
//  PitchPerfect
//
//  Created by Darin Williams on 12/26/18.
//  Copyright © 2018 dwilliams. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {

     @IBOutlet weak var snailButton: UIButton!
     @IBOutlet weak var chipmunkButton: UIButton!
     @IBOutlet weak var rabbitButton: UIButton!
     @IBOutlet weak var vaderButton: UIButton!
     @IBOutlet weak var echoButton: UIButton!
     @IBOutlet weak var reverbButton: UIButton!
     @IBOutlet weak var stopButton: UIButton!
    
     var recordedAudioURL: URL!
    
    //properties used by class extention
    var audioFile: AVAudioFile!
    var audioEngine: AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
    
    enum ButtonType: Int{ case slow = 0, fast, chipmunk, vader, echo, reverb }
    
    // MARK - Play Sound based on the button pressed
    // the button tag value is map to enum
    
    @IBAction func playSoundforButton(_ sender: UIButton){
        switch(ButtonType(rawValue: sender.tag)!) {
        case .slow:
            playSound(rate: 0.5)
        case .fast:
            playSound(rate: 1.5)
        case .chipmunk:
            playSound(pitch: 1000)
        case .vader:
            playSound(pitch: -1000)
        case .echo:
            playSound(echo: true)
        case .reverb:
            playSound(reverb: true)
        }
        
        configureUI(.playing)
    }
    
    
    @IBAction func stopButtonPressed(_ sender: AnyObject){
        stopAudio()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupAudio()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //configureUI - reset buttons to proper state when playing or not playing
        configureUI(.notPlaying)
    }

}
