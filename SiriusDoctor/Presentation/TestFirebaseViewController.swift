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
        
        let pac1 = Pacient(ID: "156059", name: "Erika Schemann", address: "Av. Nações Norte - Parque Tv, Bauru - SP", telephone: "+55 (11) 99643-2967", imageURL: "https://scontent.frao1-2.fna.fbcdn.net/v/t1.0-9/37823713_10204821084643746_5975212438394503168_o.jpg?_nc_cat=0&oh=509d8a916fbd7968200c4b947e4a5e57&oe=5C3B624C", bornDate: formatter.date(from: "1990/10/08")!, height: 1.59, weight: 55.0, drink: true, hipertension: false, diabetes: false, smoking: true)
        pacientService.savePacient(pac1)
        
        let pac2 = Pacient(ID: "164923", name: "Carlos Figueiredo", address: "Av. Paulista, 1754 - Consolacao, São Paulo - SP", telephone: "+55 (11) 99176-8970", imageURL: "https://scontent.frao1-2.fna.fbcdn.net/v/t1.0-9/38918493_1697054970414091_4152521626136608768_o.jpg?_nc_cat=0&oh=d8a6dffade16d4c2ff79d92b7ae2b1e7&oe=5C389394", bornDate: formatter.date(from: "1953/06/08")!, height: 1.77, weight: 90.0, drink: true, hipertension: true, diabetes: false, smoking: true)
        pacientService.savePacient(pac2)
        
        let pac3 = Pacient(ID: "155758", name: "Luanda Silva", address: "Rua Alberto de Salvo, 90 - Jardim Santa Genebra II (Barao Geraldo), Campinas - SP", telephone: "+55 (14) 96664-8000", imageURL: "https://scontent.frao1-2.fna.fbcdn.net/v/t1.0-9/35973177_2086993534706379_3604259674888601600_o.jpg?_nc_cat=0&oh=270eb268ba6807c64da69c399258bf9d&oe=5C323611", bornDate: formatter.date(from: "1995/06/02")!, height: 1.80, weight: 100.0, drink: true, hipertension: false, diabetes: false, smoking: false)
        pacientService.savePacient(pac3)
        
        let pac4 = Pacient(ID: "155432", name: "Frederico Portes", address: "R. Norberto Barbosa, 125 - Jardim Coral, Bauru - SP, 17064-040", telephone: "+55 (14) 96464-8000", imageURL: "https://scontent.frao1-2.fna.fbcdn.net/v/t1.0-9/36300547_1747427698644343_8452058432332103680_n.jpg?_nc_cat=0&oh=0ccd39887b13f3d5014a04b3a70dc31e&oe=5C37C692", bornDate: formatter.date(from: "1978/06/20")!, height: 1.87, weight: 103.5, drink: false, hipertension: false, diabetes: false, smoking: true)
        pacientService.savePacient(pac4)
        
        let pac5 = Pacient(ID: "204030", name: "Laura Helena Zuek", address: "R. Norberto Barbosa, 125 - Jardim Coral, Bauru - SP, 17064-040", telephone: "+55 (14) 96544-8660", imageURL: "https://scontent.frao1-2.fna.fbcdn.net/v/t1.0-9/32456298_10204466351134757_2215409367535058944_n.jpg?_nc_cat=0&oh=e15e2e15c6fbb19f9ec688707b9ceeae&oe=5C079CF1", bornDate: formatter.date(from: "2000/07/07")!, height: 1.5, weight: 46.5, drink: false, hipertension: false, diabetes: true, smoking: false)
        pacientService.savePacient(pac5)
        
        let app1 = Appointment(id: UUID().uuidString, pacient: pac1, scheduledTime: Date().addingTimeInterval(410*60), transcript: "", sinptomLog: DataLog(date: Date(), images: ["https://i1.wp.com/aguidaequesabe.com/wp-content/uploads/2010/11/Hives1.jpg?resize=337%2C308", "https://www.fotosantesedepois.com/wp-content/uploads/2014/07/Sintomas-de-Alergia-ao-Sol.jpg"], texts: ["Alergia no braço"]), reportLog: DataLog(date: Date(), images: ["https://i.imgur.com/Ju7VXkh.jpg"], texts: ["Laudo médico de exame alergia"]))
        appointmentService.saveAppointment(app1)
        
        let app2 = Appointment(id: UUID().uuidString, pacient: pac2, scheduledTime: Date().addingTimeInterval(430*60), transcript: "", sinptomLog: DataLog(date: Date(), images: ["https://tudoela.com/wp-content/uploads/2018/04/hematoma-subungueal-2.jpg"], texts: ["Pé"]), reportLog: DataLog(date: Date(), images: [], texts: []))
        appointmentService.saveAppointment(app2)
        
        let app3 = Appointment(id: UUID().uuidString, pacient: pac3, scheduledTime: Date().addingTimeInterval(455*60), transcript: "", sinptomLog: DataLog(date: Date(), images: ["https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRAKgGbsQgecyzYkIH8NcLUvyqA3oimI72vaJ0_hlzGl681MEo1", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQDxrcI047WppuCObeTgOG1ACMNOlXstAgzgCbAFvRAFuj_cDek"], texts: ["Pintas estranhas na pele"]), reportLog: DataLog(date: Date(), images: ["https://i.imgur.com/Ju7VXkh.jpg"], texts: [""]))
        appointmentService.saveAppointment(app3)

        let app4 = Appointment(id: UUID().uuidString, pacient: pac4, scheduledTime: Date().addingTimeInterval(470*60), transcript: "", sinptomLog: DataLog(date: Date(), images: ["https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRAKgGbsQgecyzYkIH8NcLUvyqA3oimI72vaJ0_hlzGl681MEo1", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQDxrcI047WppuCObeTgOG1ACMNOlXstAgzgCbAFvRAFuj_cDek"], texts: ["Pintas estranhas na pele"]), reportLog: DataLog(date: Date(), images: ["https://i.imgur.com/Ju7VXkh.jpg"], texts: [""]))
        appointmentService.saveAppointment(app4)
        
        let app5 = Appointment(id: UUID().uuidString, pacient: pac5, scheduledTime: Date().addingTimeInterval(499*60), transcript: "", sinptomLog: DataLog(date: Date(), images: ["https://i1.wp.com/aguidaequesabe.com/wp-content/uploads/2010/11/Hives1.jpg?resize=337%2C308", "https://www.fotosantesedepois.com/wp-content/uploads/2014/07/Sintomas-de-Alergia-ao-Sol.jpg"], texts: ["Alergia no braço"]), reportLog: DataLog(date: Date(), images: ["https://i.imgur.com/Ju7VXkh.jpg"], texts: ["Laudo médico de exame alergia"]))
        appointmentService.saveAppointment(app5)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
