//
//  TestFirebaseViewController.swift
//  SiriusDoctor
//
//  Created by Julianny Favinha on 8/24/18.
//  Copyright © 2018 Giovani Nascimento Pereira. All rights reserved.
//

import UIKit

class TestFirebaseViewController: UIViewController {

    @IBOutlet weak var image: UIImageView!
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
        
        let pac = Pacient(ID: "9", name: "Bia", address: "addr", telephone: "13", imageURL: "https://scontent.frao1-2.fna.fbcdn.net/v/t1.0-9/35973177_2086993534706379_3604259674888601600_o.jpg?_nc_cat=0&oh=270eb268ba6807c64da69c399258bf9d&oe=5C323611", bornDate: Date(), height: 1.0, weight: 1.0, drink: false, hipertension: false, diabetes: false, smoking: false)
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
