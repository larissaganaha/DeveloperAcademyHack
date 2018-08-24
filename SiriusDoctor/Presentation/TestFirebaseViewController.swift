//
//  TestFirebaseViewController.swift
//  SiriusDoctor
//
//  Created by Julianny Favinha on 8/24/18.
//  Copyright © 2018 Giovani Nascimento Pereira. All rights reserved.
//

import UIKit
import Kingfisher

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
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        
        let pac1 = Pacient(ID: "156059", name: "Joana Maria", address: "Rua Roxo Moreira, 157 - Cidade Universitária", telephone: "+55 (13) 99643-2967", imageURL: "https://scontent.frao1-2.fna.fbcdn.net/v/t1.0-9/35973177_2086993534706379_3604259674888601600_o.jpg?_nc_cat=0&oh=270eb268ba6807c64da69c399258bf9d&oe=5C323611", bornDate: formatter.date(from: "1990/10/08")!, height: 1.59, weight: 55.0, drink: true, hipertension: false, diabetes: false, smoking: true)
        pacientService.savePacient(pac1)
        
        let pac2 = Pacient(ID: "164923", name: "Carlos Figueiredo", address: "Av Paulista, 1000", telephone: "+55 (11) 99176-8970", imageURL: nil, bornDate: formatter.date(from: "1983/06/08")!, height: 1.77, weight: 90.0, drink: true, hipertension: true, diabetes: false, smoking: true)
        pacientService.savePacient(pac2)
        
        let pac3 = Pacient(ID: "155758", name: "Luanda Silva", address: "Rua Alberto de Salvo, 90 - Jardim Santa Genebra II (Barao Geraldo), Campinas - SP", telephone: "+55 (14) 96664-8000", imageURL: nil, bornDate: formatter.date(from: "1995/06/02")!, height: 1.80, weight: 100.0, drink: true, hipertension: false, diabetes: true, smoking: false)
        pacientService.savePacient(pac3)
        
        let app1 = Appointment(pacient: pac1, scheduledTime: formatter.date(from: "2018/12/08")!, transcript: "", sinptomLog: DataLog(date: Date(), images: ["https://www.skinmdpllc.com/sbtemplates/sbcommon/images/blog/Melanoma.jpg", "https://www.fotosantesedepois.com/wp-content/uploads/2014/07/Sintomas-de-Alergia-ao-Sol.jpg"], texts: ["dor de estômago"]), reportLog: DataLog(date: Date(), images: [], texts: []))
        appointmentService.saveAppointment(app1)
        
        let app2 = Appointment(pacient: pac2, scheduledTime: formatter.date(from: "2019/01/03")!, transcript: "", sinptomLog: DataLog(date: Date(), images: ["http://s2.glbimg.com/3DqkyxE0mubo8zZ3wGZ6bOuGMtUuhCfE-UePrWhWJXoeFijuJJyy22W7__T6PeaS/s.glbimg.com/es/ge/f/original/2012/10/04/pe_da_mayara.jpg", "http://4.bp.blogspot.com/-rXmxiV3Y8BY/VaFdGQ84reI/AAAAAAAADB0/IYpe8iGZ8K0/s1600/11693208_1018902954796060_33698806_n.jpg"], texts: ["bati o pé gente olha que horror!"]), reportLog: DataLog(date: Date(), images: [], texts: []))
        appointmentService.saveAppointment(app2)
        
        let app3 = Appointment(pacient: pac3, scheduledTime: formatter.date(from: "2018/10/31")!, transcript: "", sinptomLog: DataLog(date: Date(), images: ["https://tudoela.com/wp-content/uploads/2018/04/hematoma-subungueal-2.jpg"], texts: ["bati o pé gente olha que horror!"]), reportLog: DataLog(date: Date(), images: [], texts: []))
        appointmentService.saveAppointment(app3)
        
        appointmentService.getAllAppointments { (apps) in
            print(apps!)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
