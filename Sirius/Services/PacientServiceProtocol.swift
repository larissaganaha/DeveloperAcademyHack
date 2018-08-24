//
//  PacientServiceProtocol.swift
//  Sirius
//
//  Created by Giovani Nascimento Pereira on 24/08/18.
//  Copyright © 2018 Giovani Nascimento Pereira. All rights reserved.
//

import Foundation

protocol PacientServiceProtocol {
    
    func getPacient(id: String, completionHandler: @escaping (Pacient?) -> Void)
    func savePacient(_ pacient: Pacient)
    func getAppointmentPacient() -> [Appointment]
    func updateAppointment(_ appointment: Appointment)
    func getWaitTime() -> Date
    
}
