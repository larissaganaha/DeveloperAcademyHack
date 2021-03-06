//
//  HomeScreenController.swift
//  Sirius
//
//  Created by Larissa Ganaha on 24/08/18.
//  Copyright © 2018 Giovani Nascimento Pereira. All rights reserved.
//

import UIKit



class HomeScreenController: UIViewController {

    var tableViewIndex: Int = 0

    var categories = ["Consultas futuras", "Consultas passadas"]
    var pacient: Pacient?

    var activeAppoints: [Appointment] = []
    var unactiveAppoints: [Appointment] = []
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var lagTimeLabel: UILabel!
    @IBOutlet weak var lagTimeTitleLabel: UILabel!
    @IBOutlet weak var activityIndication: UIActivityIndicatorView!
    @IBOutlet weak var loadingView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.activityIndication.hidesWhenStopped = true
        self.activityIndication.startAnimating()
        
        PacientFirebaseMechanism.shared.retrievePacient(id: "164923") { (pacient) in
            if let pacient = pacient {
                self.pacient = pacient
                
                AppointmentMechanismFirebase.shared.retrieveAppointments(from: pacient.ID, completionHandler: { (appointments) in
                    if let appointments = appointments {
                        self.activeAppoints = appointments.filter{ $0.isActive }.sorted(by: { (app1, app2) -> Bool in
                            return app1.scheduledTime.compare(app2.scheduledTime) == ComparisonResult.orderedAscending
                        })
                        self.unactiveAppoints = appointments.filter{ !$0.isActive }.sorted(by: { (app1, app2) -> Bool in
                            return app1.scheduledTime.compare(app2.scheduledTime) == ComparisonResult.orderedAscending
                        })
                        print(self.activeAppoints)
                        print(self.unactiveAppoints)
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                        
                        LagTimeService.getLagTime(completion: { (lagtime) in
                            self.updateLagTimeLabel(lagtime: lagtime)
                        })
                        
                        self.reloadNextAppointmentLabels()
                        
                        self.updateLagTimeIfNecessary()
                    }
                })
            }
        }
        lagTimeLabel.layer.cornerRadius = 17
        lagTimeLabel.clipsToBounds = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destiny = segue.destination as? NextAppointmentController {
            destiny.pacient = self.pacient
            destiny.appointment = self.activeAppoints.first
        }
    }
    
    private func reloadNextAppointmentLabels() {
        if let pacient = self.pacient, let firstAppoint = self.activeAppoints.first {
            self.welcomeLabel.text = "Olá, \(pacient.name.components(separatedBy: " ").first ?? pacient.name). Sua próxima consulta é:"
            self.dateLabel.text = "Data: \(firstAppoint.scheduledTime.toString(dateFormat: "dd/MM/yyyy"))"
            let hour = Calendar.current.component(.hour, from: firstAppoint.scheduledTime)
            let minute = Calendar.current.component(.minute, from: firstAppoint.scheduledTime)
            self.timeLabel.text = "Horário: \(hour)h\(minute)min"
            
            let order = Calendar.current.compare(Date(), to: firstAppoint.scheduledTime, toGranularity: .day)
            switch order {
            case .orderedSame:
                lagTimeLabel.isHidden = false
                lagTimeTitleLabel.isHidden = false
            case .orderedAscending:
                lagTimeLabel.isHidden = true
                lagTimeTitleLabel.isHidden = true
            case .orderedDescending:
                lagTimeLabel.isHidden = true
                lagTimeTitleLabel.isHidden = true
            }
            self.activityIndication.stopAnimating()
            self.loadingView.isHidden = true
        }
    }
    
    fileprivate func updateLagTimeLabel(lagtime: Int?) {
        if lagtime != nil {
            let hours = lagtime!/60
            if lagtime == 0 {
                self.lagTimeLabel.text = "Sem espera"
            } else {
                if  hours > 0 {
                    self.lagTimeLabel.text = "+\(hours)h\(lagtime!%60)min"
                } else {
                    self.lagTimeLabel.text = "\(lagtime!) min"
                }
            }
        }
    }
    
    func updateLagTimeIfNecessary() {
        let dayOfNextAppoint = Calendar.current.component(.day, from: (self.activeAppoints.first?.scheduledTime)!)
        let currDay = Calendar.current.component(.day, from: Date())
        
        if dayOfNextAppoint == currDay {
            LagTimeMechanismFirebase.shared.addObserverEventAdded { (lagTime) in
                self.updateLagTimeLabel(lagtime: lagTime)
            }
        }
    }

    @IBAction func unwindToHomeScreen(segue:UIStoryboardSegue) { }

    @IBAction func checkInPressed(_ sender: Any) {
        displayAlert()
    }

    func displayAlert() {
        let alertController = UIAlertController(title: "Check-in feito!", message: "Seu checkin foi realizado com sucesso", preferredStyle: .alert)
        let settingsButton = UIAlertAction(title: "Ok", style: .default, handler: { action in
            self.performSegue(withIdentifier: "showWaitScreen", sender: nil)
        })
        alertController.addAction(settingsButton)
        self.present(alertController, animated: true, completion: nil)
    }

}
extension HomeScreenController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath) as? HomeScreenTableCell {
            if indexPath.section == 0 { cell.appoints = self.activeAppoints }
            else { cell.appoints = self.unactiveAppoints }
            return cell
        }
        return HomeScreenTableCell()
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return categories.count
    }



    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        let titleLabel = UILabel()
        
        titleLabel.textAlignment = .left
        titleLabel.font = UIFont(name: "Poppins-SemiBold", size: 19)
        titleLabel.text = self.categories[section]
        titleLabel.frame = CGRect(x: 20, y: 10, width: view.bounds.width, height: 30)
        titleLabel.textColor = .white
        headerView.addSubview(titleLabel)
        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35
    }

}
