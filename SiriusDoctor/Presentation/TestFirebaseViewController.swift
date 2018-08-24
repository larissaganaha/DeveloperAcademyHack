//
//  TestFirebaseViewController.swift
//  SiriusDoctor
//
//  Created by Julianny Favinha on 8/24/18.
//  Copyright © 2018 Giovani Nascimento Pereira. All rights reserved.
//

import UIKit

class TestFirebaseViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    var pacientService: PacientService! = PacientService()
    var appointmentService: AppointmentService = AppointmentService()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pacientService.getPacient(id: "1") { (pacient) in
            if let actualPacient = pacient {
                DispatchQueue.main.async {
                    self.label.text = actualPacient.name
                }
            }
        }
        
        let pac = Pacient(ID: "9", name: "Bia", address: "addr", telephone: "13", bornDate: Date(), height: 1.0, weight: 1.0, drink: false, hipertension: false, diabetes: false, smoking: false)
        pacientService.savePacient(pac)
        
        let app = Appointment(pacient: pac, scheduledTime: Date(), transcript: "LALALA SUSHI", sinptomLog: nil, reportLog: nil)
        appointmentService.saveAppointment(app)
        
        appointmentService.getAllAppointments { (apps) in
            print(apps!)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
