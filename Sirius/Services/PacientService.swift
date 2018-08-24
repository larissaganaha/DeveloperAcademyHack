//
//  PacientService.swift
//  Sirius
//
//  Created by Giovani Nascimento Pereira on 24/08/18.
//  Copyright © 2018 Giovani Nascimento Pereira. All rights reserved.
//

import Foundation

class PacientService: PacientServiceProtocol {
    
    func getPacient() -> Pacient {
        return Pacient()
    }
    func savePacient(_ pacient: Pacient) {
        
    }
    func getAppointmentPacient() -> [Appointment] {
        return []
    }
    func updateAppointment(_ appointment: Appointment) {
        
    }
    func getWaitTime() -> Date {
        return Date()
    }
    
}
