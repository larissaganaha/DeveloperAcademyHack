//
//  ViewController.swift
//  SiriusDoctor
//
//  Created by Giovani Nascimento Pereira on 24/08/18.
//  Copyright © 2018 Giovani Nascimento Pereira. All rights reserved.
//

import UIKit

class AppointmentViewController: UIViewController {
    
    var pacient: Pacient = DataMock.pacient
    var appointment: Appointment = DataMock.appointments[0]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
}
extension AppointmentViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "profileCell") as? ProfileTableViewCell else { return UITableViewCell() }
            cell.name.text = self.pacient.name
            cell.address.text = self.pacient.address
            cell.id.text = "MEDICAL ID: \(self.pacient.ID)"
            cell.telephone.text = self.pacient.telephone
            let age: Int = Int(pacient.age)
            cell.age.text = "\(age) anos"
            
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "pInfoCell") as? InfoTableViewCell else { return UITableViewCell() }
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "appointmentInfoCell") as? PacientInfoTableViewCell else { return UITableViewCell() }
            return cell
        case 3:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "relevantImagesCell") as? RelevantImagesTableViewCell else { return UITableViewCell() }
            cell.title.text = "Imagens Relevantes"
            if let log = appointment.sinptomLog?.images {
                cell.images = log
            }
            return cell
        case 4:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "relevantImagesCell") as? RelevantImagesTableViewCell else { return UITableViewCell() }
            cell.title.text = "Exames e Laudos Passados"
            if let log = appointment.reportLog?.images {
                cell.images = log
            }
            return cell
        case 5:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "endCell") as? EndTableViewCell else { return UITableViewCell() }
            return cell
        default:
            return UITableViewCell()
        }
    }
    
}
