//
//  VoiceRecognition.swift
//  SiriusDoctor
//
//  Created by Giovani Nascimento Pereira on 24/08/18.
//  Copyright © 2018 Giovani Nascimento Pereira. All rights reserved.
//

import Foundation
import UIKit
import Speech

protocol VoiceRecognitioniewDelegate: class {
    func enableMicrophone()
    func disableMicrophone()
    func transcriptedTextDidChange(newText: String)
    func finishedTranscript(transcript: String)
}

class VoiceRecognition: NSObject {
    
    private weak var viewDelegate: VoiceRecognitioniewDelegate!
    private var text: String = ""
    
    private var speechRecognizer: SFSpeechRecognizer!
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine()
    private let languageID = Locale(identifier: "pt_BR")
    
    init(viewDelegate: VoiceRecognitioniewDelegate) {
        
        self.viewDelegate = viewDelegate
        self.speechRecognizer = SFSpeechRecognizer(locale: languageID)!
        super.init()
        speechRecognizer.delegate = self
        requestAuthorization()
    }
    
    func requestAuthorization() {
        SFSpeechRecognizer.requestAuthorization { (authStatus) in
            
            var isButtonEnabled = false
            
            switch authStatus {
            case .authorized:
                isButtonEnabled = true
                
            case .denied:
                isButtonEnabled = false
                print("User denied access to speech recognition")
                
            case .restricted:
                isButtonEnabled = false
                print("Speech recognition restricted on this device")
                
            case .notDetermined:
                isButtonEnabled = false
                print("Speech recognition not yet authorized")
            }
            
            OperationQueue.main.addOperation {
                if isButtonEnabled {
                    self.viewDelegate.enableMicrophone()
                } else {
                    self.viewDelegate.disableMicrophone()
                }
            }
        }
    }
    
    func startRecognitionRequest(_ recognitionRequest: SFSpeechAudioBufferRecognitionRequest,
                                 _ inputNode: AVAudioInputNode) {
        recognitionTask = speechRecognizer.recognitionTask(with: recognitionRequest, resultHandler: { (result, error) in
            
            var isFinal = false
            
            if let result = result {
                let currentTranscription = result.bestTranscription.formattedString
                self.viewDelegate.transcriptedTextDidChange(newText: currentTranscription)
                self.text = currentTranscription
                isFinal = result.isFinal
            }
            
            if error != nil || isFinal {
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)
                
                self.recognitionRequest = nil
                self.recognitionTask = nil
                
                self.viewDelegate.enableMicrophone()
            }
        })
    }
    
    func startRecording() {
        self.speechRecognizer = SFSpeechRecognizer(locale: languageID)!
        
        if let task = recognitionTask {
            task.cancel()
            recognitionTask = nil
        }
        
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(AVAudioSessionCategoryRecord)
            try audioSession.setMode(AVAudioSessionModeMeasurement)
            try audioSession.setActive(true, with: .notifyOthersOnDeactivation)
        } catch {
            print("audioSession properties weren't set because of an error.")
        }
        
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        
        let inputNode = audioEngine.inputNode
        
        guard let recognitionRequest = recognitionRequest else {
            fatalError("Unable to create an SFSpeechAudioBufferRecognitionRequest object")
        }
        
        recognitionRequest.shouldReportPartialResults = true
        
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, _) in
            self.recognitionRequest?.append(buffer)
        }
        
        startRecognitionRequest(recognitionRequest, inputNode)
        
        audioEngine.prepare()
        
        do {
            try audioEngine.start()
            self.viewDelegate.disableMicrophone()
        } catch {
            print("audioEngine couldn't start because of an error.")
        }
    }
    
    func stopRecording() {
        audioEngine.stop()
        recognitionRequest?.endAudio()
        viewDelegate.enableMicrophone()
        viewDelegate.finishedTranscript(transcript: self.text)
    }
    
}

extension VoiceRecognition: SFSpeechRecognizerDelegate {
    
    func speechRecognizer(_ speechRecognizer: SFSpeechRecognizer, availabilityDidChange available: Bool) {
        if available {
            viewDelegate.enableMicrophone()
        } else {
            viewDelegate.disableMicrophone()
        }
    }
}
