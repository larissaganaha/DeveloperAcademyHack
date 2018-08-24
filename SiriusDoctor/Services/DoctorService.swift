//
//  DoctorService.swift
//  SiriusDoctor
//
//  Created by Giovani Nascimento Pereira on 24/08/18.
//  Copyright © 2018 Giovani Nascimento Pereira. All rights reserved.
//

import Foundation

class DoctorService: DoctorServiceProtocol {
    
    func getAppointments() -> [Appointment] {
        return []
    }
    func saveAppointment(_ appointment: Appointment) {
        
    }
    func getPacient(id: String) -> Pacient {
        return Pacient()
    }
    
}
