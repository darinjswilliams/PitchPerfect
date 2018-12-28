//
//  ViewController.swift
//  PitchPerfect
//
//  Created by Darin Williams on 12/23/18.
//  Copyright © 2018 dwilliams. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var recordingLabel: UILabel!
    
    @IBOutlet weak var recordButton: UIButton!
    
    @IBOutlet weak var stopRecordingButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Disable the stop recording button
        stopRecordingButton.isEnabled = false
    }

    //Gets call before root view appears on screen
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear Called")
    }
    
    //Gets call immediately after the view appear on screen
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    @IBAction func recordAudio(_ sender: Any) {
    //Disable and enable the buttons, User is recording
    recordingLabel.text = "Recording in Progress"
    stopRecordingButton.isEnabled = true
    recordButton.isEnabled = false
    }
    
    @IBAction func stopRecording(_ sender: Any) {
     //Enable Record Button
     recordButton.isEnabled = true
     stopRecordingButton.isEnabled = false
     recordingLabel.text = "Tap to Record"
      
    }
}

