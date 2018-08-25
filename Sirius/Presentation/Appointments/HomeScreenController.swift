//
//  HomeScreenController.swift
//  Sirius
//
//  Created by Larissa Ganaha on 24/08/18.
//  Copyright © 2018 Giovani Nascimento Pereira. All rights reserved.
//

import UIKit
import CoreLocation

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
                        self.activeAppoints = appointments.filter{ $0.isActive }
                        self.unactiveAppoints = appointments.filter{ !$0.isActive}
                        
                        self.updateLagTimeIfNecessary()
                    }
                })
            }
        }
        //Coordenadas do Elds
        let geofenceRegionCenter = CLLocationCoordinate2DMake(-22.812454, -47.061487)
        
        let geofenceRegion = CLCircularRegion(center: geofenceRegionCenter, radius: 100, identifier: "identifier")
        
        geofenceRegion.notifyOnEntry = true
        geofenceRegion.notifyOnExit = false
        
        let locationManager = CLLocationManager()
        locationManager.startMonitoring(for: geofenceRegion)
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
