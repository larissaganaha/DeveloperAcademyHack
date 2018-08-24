//
//  VoiceRecognitionTestViewController.swift
//  SiriusDoctor
//
//  Created by Giovani Nascimento Pereira on 24/08/18.
//  Copyright © 2018 Giovani Nascimento Pereira. All rights reserved.
//

import UIKit

class VoiceRecognitionTestViewController: UIViewController {

    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var sinptomsLabel: UILabel!
    @IBOutlet weak var medicineLabel: UILabel!
    
    var voiceRecognitionMechanism: VoiceRecognition?
    var isRecording: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.voiceRecognitionMechanism = VoiceRecognition(viewDelegate: self)
    }

    @IBAction func recordButtonPressed(_ sender: Any) {
        if !isRecording {
            voiceRecognitionMechanism?.startRecording()
        } else {
            voiceRecognitionMechanism?.stopRecording()
        }
    }
}

extension VoiceRecognitionTestViewController: VoiceRecognitioniewDelegate {
    func enableMicrophone() {
        self.recordButton.setTitle("Record", for: .normal)
        self.recordButton.tintColor = .blue
        self.isRecording = false
    }
    
    func disableMicrophone() {
        self.recordButton.setTitle("Pause", for: .normal)
        self.recordButton.tintColor = .red
        self.isRecording = true
    }
    
    func transcriptedTextDidChange(newText: String) {
        self.label.text = newText
    }
    
    func finishedTranscript(transcript: String) {
        print(transcript)
        
        sinptomsLabel.text = VoiceRecognitionReference.identifySimptoms(from: transcript).reduce("", { (result, text) -> String in
            result + "\n" + text
        })
        
        
    }
}
