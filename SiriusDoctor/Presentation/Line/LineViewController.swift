//
//  LineViewController.swift
//  SiriusDoctor
//
//  Created by Giovani Nascimento Pereira on 24/08/18.
//  Copyright © 2018 Giovani Nascimento Pereira. All rights reserved.
//

import UIKit
import Kingfisher
import Foundation

class LineViewController: UIViewController {
    
    var appointments: [Appointment] = []
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activity: UIActivityIndicatorView!
    var timer: Timer = Timer()

    var lagTime = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadData()
    }
    
    func reloadData() {
        activity.startAnimating()
        AppointmentService().getAllActiveAppointments { (appointments) in
            if let app = appointments {
                self.appointments = app.sorted(by: { (app1, app2) -> Bool in
                    return app1.scheduledTime.compare(app2.scheduledTime) == ComparisonResult.orderedAscending
                })
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.updateLagTime()

                    self.activity.stopAnimating()
                }
            }
        }
        //Atualizar o lag time a cada 5 minutos
        timer = Timer.scheduledTimer(timeInterval: 30, target: self,
                                     selector: #selector(updateLagTime),
                                     userInfo: nil, repeats: true)
    }
    
    @IBAction func createAppointment(_ sender: Any) {
        performSegue(withIdentifier: "createAppointment", sender: self)
    }
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? AppointmentViewController,
            let appointment = sender as? Appointment {
            viewController.appointment = appointment
            viewController.pacient = appointment.pacient
        }
    }
    
    @objc func updateLagTime(){
        //Possible lag será horário atual - (horário final da primeira consulta da fila + 20 minutos)
        var possibleLag = 0
        
        if self.appointments.count > 0{
            //Date() - scheduledTime
            possibleLag = Date().minutes(from: self.appointments[0].scheduledTime)
        }
        
        //Se possibleLag > 0, há atraso
        if possibleLag > 0 {
            let lagTime = LagTime(lagTime: possibleLag)
            LagTimeService.updateLagTime(lagTime: lagTime)
        } else {
            let lagTime = LagTime(lagTime: 0)
            LagTimeService.updateLagTime(lagTime: lagTime)
        }
    }
}

extension Date {
    /// Returns the amount of minutes from another date
    func minutes(from date: Date) -> Int {
        return Calendar.current.dateComponents([.minute], from: date, to: self).minute ?? 0
    }

    /// Returns the a custom time interval description from another date
    func offset(from date: Date) -> String {
        if minutes(from: date) > 0 { return "\(minutes(from: date))m" }
        return ""
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
        cell.age.text = "\(Int(app.pacient.age)) anos"
        cell.profileImage.kf.setImage(with: app.pacient.realURL, placeholder: #imageLiteral(resourceName: "profilePicturePlaceholder"), options: nil, progressBlock: nil, completionHandler: nil)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
        cell.time.text = "\(dateFormatter.string(from: app.scheduledTime))"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 { return }
        self.performSegue(withIdentifier: "appointmentSegue", sender: self.appointments[indexPath.row - 1])
    }
    
}
