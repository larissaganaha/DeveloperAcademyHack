//
//  LineViewController.swift
//  SiriusDoctor
//
//  Created by Giovani Nascimento Pereira on 24/08/18.
//  Copyright © 2018 Giovani Nascimento Pereira. All rights reserved.
//

import UIKit
import Kingfisher

class LineViewController: UIViewController {
    
    var appointments: [Appointment] = []
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activity: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activity.startAnimating()
        AppointmentService().getAllAppointments { (appointments) in
            if let app = appointments {
                self.appointments = app
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.activity.stopAnimating()
                }
            }
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? AppointmentViewController,
            let appointment = sender as? Appointment {
            viewController.appointment = appointment
            viewController.pacient = appointment.pacient
        }
    }
}

extension LineViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.appointments.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "titleCell") else { return UITableViewCell()}
            return cell
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "lineCell") as? LineTableViewCell else { return UITableViewCell()}
        
        let app = appointments[indexPath.row - 1]
        cell.id.text = "Medical ID: \(app.pacient.ID)"
        cell.name.text = app.pacient.name
        cell.age.text = "\(Int(app.pacient.age))"
        cell.profileImage.kf.setImage(with: app.pacient.realURL, placeholder: #imageLiteral(resourceName: "profilePicturePlaceholder"), options: nil, progressBlock: nil, completionHandler: nil)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        cell.time.text = "Horário da Consulta: \(dateFormatter.string(from: app.scheduledTime))"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "appointmentSegue", sender: self.appointments[indexPath.row - 1])
    }
    
}
