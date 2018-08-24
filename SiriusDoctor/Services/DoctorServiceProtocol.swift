//
//  DoctorServiceProtocol.swift
//  SiriusDoctor
//
//  Created by Giovani Nascimento Pereira on 24/08/18.
//  Copyright © 2018 Giovani Nascimento Pereira. All rights reserved.
//

import Foundation

protocol DoctorServiceProtocol {
    
    func getAppointments() -> [Appointment]
    func saveAppointment(_ appointment: Appointment)
    func getPacient(id: String) -> Pacient
    
}
