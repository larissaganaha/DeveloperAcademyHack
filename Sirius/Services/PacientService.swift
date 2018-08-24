//
//  PacientService.swift
//  Sirius
//
//  Created by Giovani Nascimento Pereira on 24/08/18.
//  Copyright © 2018 Giovani Nascimento Pereira. All rights reserved.
//

import Foundation

class PacientService: PacientServiceProtocol {
    
    func getPacient(id: String, completionHandler: @escaping (Pacient?) -> Void) {
        PacientFirebaseMechanism.shared.retrievePacient(id: id, completionHandler: completionHandler)
        
//        return PacientMechanisMock.getPacient()
    }
    func savePacient(_ pacient: Pacient) {
        PacientMechanisMock.savePacient(pacient)
    }
    func getAppointmentPacient() -> [Appointment] {
        return PacientMechanisMock.getPacientAppointments()
    }
    func updateAppointment(_ appointment: Appointment) {
        PacientMechanisMock.updateAppointment(appointment)
    }
    func getWaitTime() -> Date {
        return PacientMechanisMock.getWaitTime()
    }
    
}
