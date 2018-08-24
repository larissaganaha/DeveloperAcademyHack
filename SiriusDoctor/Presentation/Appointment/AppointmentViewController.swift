//
//  ViewController.swift
//  SiriusDoctor
//
//  Created by Giovani Nascimento Pereira on 24/08/18.
//  Copyright © 2018 Giovani Nascimento Pereira. All rights reserved.
//

import UIKit
import Kingfisher

class AppointmentViewController: UIViewController {
    
    var pacient: Pacient = DataMock.pacient
    var appointment: Appointment = DataMock.appointments[0]
    var transcript: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        self.transcript = appointment.transcript
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? TranscriptViewController {
            viewController.transcript = self.transcript
            viewController.delegate = self
        }
        if let viewController = segue.destination as? ImageViewController,
            let image = sender as? UIImage {
            viewController.image = image
        }
    }
    
    func saveAppointment() {
        appointment.transcript = self.transcript
        AppointmentService().saveAppointment(appointment)
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
            cell.delegate = self
            cell.name.text = self.pacient.name
            cell.address.text = self.pacient.address
            cell.id.text = "MEDICAL ID: \(self.pacient.ID)"
            cell.telephone.text = self.pacient.telephone
            let age: Int = Int(pacient.age)
            cell.age.text = "\(age) anos"
            cell.picture.kf.setImage(with: pacient.realURL, placeholder: #imageLiteral(resourceName: "profilePicturePlaceholder"), options: nil, progressBlock: nil, completionHandler: nil)
            
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "pInfoCell") as? InfoTableViewCell else { return UITableViewCell() }
            cell.personalInfo = pacient.personalInfo
            cell.familyHistory = pacient.familyHistory
            cell.medications = pacient.medicines
            return cell
        case 4:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "appointmentInfoCell") as? PacientInfoTableViewCell else { return UITableViewCell() }
            cell.delegate = self
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "relevantImagesCell") as? RelevantImagesTableViewCell else { return UITableViewCell() }
            cell.title.text = "Imagens Relevantes"
            if let log = appointment.sinptomLog?.images {
                cell.images = log.map { URL(string: $0)!}
            }
            return cell
        case 3:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "relevantImagesCell") as? RelevantImagesTableViewCell else { return UITableViewCell() }
            cell.title.text = "Exames e Laudos Passados"
            if let log = appointment.reportLog?.images {
                cell.images = log.map { URL(string: $0)!}
            }
            cell.delegate = self
            return cell
        case 5:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "endCell") as? EndTableViewCell else { return UITableViewCell() }
            cell.delegate = self 
            return cell
        default:
            return UITableViewCell()
        }
    }
}

extension AppointmentViewController: BackCellDelegate {
    func backButtonPressed() {
        self.saveAppointment()
        self.dismiss(animated: true, completion: nil)
    }
}

extension AppointmentViewController: EndCellDelegate {
    func endButtonPressed() {
        self.appointment.isActive = false
        self.saveAppointment()
        self.dismiss(animated: true, completion: nil)
    }
}

extension AppointmentViewController: TranscriptCellProtocol, TranscriptEditProtocol {
    func updateTranscript(to text: String) {
        self.transcript = text
    }
    func transcriptButtonPressed() {
        self.performSegue(withIdentifier: "showTranscript", sender: self)
    }
}

extension AppointmentViewController: RelevantImagesProtocol {
    func imageSelected(_ image: UIImage?) {
        self.performSegue(withIdentifier: "showImage", sender: image)
    }
}
