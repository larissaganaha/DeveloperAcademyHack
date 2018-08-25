//
//  NextAppointmentController.swift
//  Sirius
//
//  Created by Larissa Ganaha on 24/08/18.
//  Copyright © 2018 Giovani Nascimento Pereira. All rights reserved.
//

import UIKit

class NextAppointmentController: UIViewController {
    
    @IBOutlet weak var goBackButton: UIButton!
    @IBOutlet weak var symptomsTextField: UITextField!
    @IBOutlet weak var addPhotoButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        goBackButton.layer.cornerRadius = 12
        addPhotoButton.layer.cornerRadius = 17
        symptomsTextField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func goBackPressed(_ sender: Any) {
        performSegue(withIdentifier: "unwindToWaitScreen", sender: nil)

    }
}

extension NextAppointmentController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
