//
//  HomeScreenController.swift
//  Sirius
//
//  Created by Larissa Ganaha on 24/08/18.
//  Copyright © 2018 Giovani Nascimento Pereira. All rights reserved.
//

import UIKit

class HomeScreenController: UIViewController {

    var categories = ["Consultas futuras", "Consultas passadas"]
    var pacient:Pacient?

    var activeAppoints:[Appointment] = []
    var unactiveAppoints:[Appointment] = []
    
    @IBOutlet weak var lagTimeLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
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
                        
                        LagTimeService.getLagTime(completion: { (lagtime) in
                            let hours = lagtime!/60
                            if  hours > 0 {
                                self.lagTimeLabel.text = "\(hours)h\(lagtime!%60)min"
                            } else {
                                self.lagTimeLabel.text = "00h\(lagtime!) min"
                            }
                        })
                        
                        self.updateLagTimeIfNecessary()
                    }
                })
            }
        }
        lagTimeLabel.layer.cornerRadius = 17
        lagTimeLabel.clipsToBounds = true
    }
    
    func updateLagTimeIfNecessary(){
        let dayOfNextAppoint = Calendar.current.component(.day, from: (self.activeAppoints.first?.scheduledTime)!)
        let currDay = Calendar.current.component(.day, from: Date())
        
        if dayOfNextAppoint == currDay {
            LagTimeMechanismFirebase.shared.addObserverEventAdded { (lagTime) in
                self.lagTimeLabel.text = String(lagTime!)
                print(lagTime ?? -999)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
