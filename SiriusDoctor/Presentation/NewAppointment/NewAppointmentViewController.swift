//
//  NewAppointmentViewController.swift
//  SiriusDoctor
//
//  Created by Giovani Nascimento Pereira on 25/08/18.
//  Copyright © 2018 Giovani Nascimento Pereira. All rights reserved.
//

import UIKit

class NewAppointmentViewController: UIViewController {

    @IBOutlet weak var pacientTableView: UITableView!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var pacients: [Pacient] = []
    var selectedPacient: Pacient?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PacientService().getAllPacients { (pacients) in
            if let pacients = pacients {
                self.pacients = pacients
                DispatchQueue.main.async {
                    self.pacientTableView.reloadData()
                }
            }
        }
    }

    @IBAction func goBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func saveAppointment(_ sender: Any) {
        
        guard let pacient2 = self.selectedPacient else {
            let alert = UIAlertController(title: "Paciente não selecionado", message: "Selecione um paciente para a consulta antes de salvá-la", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        let appointment = Appointment(id: UUID().uuidString, pacient: pacient2, scheduledTime: datePicker.date, transcript: "", sinptomLog: nil, reportLog: nil)
        AppointmentService().saveAppointment(appointment)
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension NewAppointmentViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == pacientTableView {
            return self.pacients.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "pacientCell") as? PacientNewAppointmentTableViewCell else { return UITableViewCell() }
        cell.setup(pacients[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedPacient = pacients[indexPath.row]
    }
    
}
