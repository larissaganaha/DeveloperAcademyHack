//
//  PacientTableViewCell.swift
//  SiriusDoctor
//
//  Created by Giovani Nascimento Pereira on 24/08/18.
//  Copyright © 2018 Giovani Nascimento Pereira. All rights reserved.
//

import UIKit

class PacientInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var simptomsTextField: UITextView!
    @IBOutlet weak var medicineTextField: UITextView!
    
    // Voice Recognition stuff
    var isRecording: Bool = false
    var transcript: String = ""
    var voiceRecognitionMechanism: VoiceRecognition?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.voiceRecognitionMechanism = VoiceRecognition(viewDelegate: self)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func recordButtonPressed(_ sender: Any) {
        if !isRecording {
            voiceRecognitionMechanism?.startRecording()
        } else {
            voiceRecognitionMechanism?.stopRecording()
        }
    }

}

extension PacientInfoTableViewCell: VoiceRecognitioniewDelegate {
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
        self.transcript = newText
    }
    
    func finishedTranscript(transcript: String) {
        print(transcript)
        
        simptomsTextField.text = VoiceRecognitionReference.identifySimptoms(from: transcript).reduce("", { (result, text) -> String in
            result + "\n" + text
        })
        medicineTextField.text = VoiceRecognitionReference.identifyMedicines(from: transcript).reduce("", { (result, text) -> String in
            result + "\n" + text
        })
        
    }
}
