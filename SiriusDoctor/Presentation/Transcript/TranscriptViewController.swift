//
//  TranscriptViewController.swift
//  SiriusDoctor
//
//  Created by Giovani Nascimento Pereira on 24/08/18.
//  Copyright © 2018 Giovani Nascimento Pereira. All rights reserved.
//

import UIKit

class TranscriptViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var titleLabel: UILabel!
    
    weak var delegate: TranscriptEditProtocol?
    var transcript: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.textView.text = transcript
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        delegate?.updateTranscript(to: textView.text)
        self.dismiss(animated: true, completion: nil)
    }
    
}

protocol TranscriptEditProtocol: NSObjectProtocol {
    func updateTranscript(to text: String)
}
