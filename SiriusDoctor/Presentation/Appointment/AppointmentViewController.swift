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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
}
extension AppointmentViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "profileCell") as? ProfileTableViewCell else { return UITableViewCell() }
            cell.name.text = self.pacient.name
            cell.address.text = self.pacient.address
            cell.id.text = "MEDICAL ID: \(self.pacient.ID)"
            cell.telephone.text = self.pacient.telephone
            
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "pacientInfoCell") as? PacientInfoTableViewCell else { return UITableViewCell() }
            return cell
        default:
            return UITableViewCell()
        }
    }
    
}