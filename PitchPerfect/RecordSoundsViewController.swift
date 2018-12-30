//
//  RecordSoundsViewController.swift
//  PitchPerfect
//
//  Created by Darin Williams on 12/23/18.
//  Copyright © 2018 dwilliams. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {

    var audioRecorder: AVAudioRecorder!
    @IBOutlet weak var recordingLabel: UILabel!
    
    @IBOutlet weak var recordButton: UIButton!
    
    @IBOutlet weak var stopRecordingButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Disable the stop recording button on loading the view
        toggleRecordingButtons(isRecording: false)
    }

    //Gets call before root view appears on screen
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    //Gets call immediately after the view appear on screen
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    //MARK recordAudio function
    @IBAction func recordAudio(_ sender: Any) {
    //Disable and enable the buttons, User is recording
        toggleRecordingButtons(isRecording: true)
    
    let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
    let recordingName = "recordedVoice.wav"
    let pathArray = [dirPath, recordingName]
    let filePath = URL(string: pathArray.joined(separator: "/"))
        print(filePath!)
        
    let session = AVAudioSession.sharedInstance()
    try! session.setCategory(AVAudioSession.Category.playAndRecord, mode: AVAudioSession.Mode.default, options: AVAudioSession.CategoryOptions.defaultToSpeaker)
    
    try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
    //Tell the AVAudioRecorder that the RecordSoundsViewController to act as Delegate
    audioRecorder.delegate = self
        
    audioRecorder.isMeteringEnabled = true
    audioRecorder.prepareToRecord()
    audioRecorder.record()
    }
    
    //MARK stopRecording function
    @IBAction func stopRecording(_ sender: Any) {
     //Enable Record Button by passing false to disable recording session
     toggleRecordingButtons(isRecording: false)
        
    //Stop the recording and set the share AVAudioSession to inactive
      audioRecorder.stop()
      let audioSession = AVAudioSession.sharedInstance()
      try! audioSession.setActive(false)
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        
        if flag {
        performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
        } else {
        print("recording was not sucessful")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stopRecording" {
            
            //perform an upcast to PlaySoundsViewController
            let playSoundVC = segue.destination as! PlaySoundsViewController
            
            //Assign the URL to variable and reassign it to variable in PlaySoundVC
            let recordedAudioURL = sender as! URL
            playSoundVC.recordedAudioURL = recordedAudioURL
        }
    }
    
    //MARK toogle recording buttons, keeping track of state
    // when stop recording is false, the recording button must be tap to begin recording
    // tapping the recording button changes the state to true and disable the stop recording button
    func toggleRecordingButtons(isRecording: Bool){
        
        recordingLabel.text =  isRecording ? "Recording in Progress" : "Tap to record"
        stopRecordingButton.isEnabled = isRecording
        recordButton.isEnabled = !isRecording
        


    }
}

