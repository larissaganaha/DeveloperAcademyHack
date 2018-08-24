//
//  PacientMechanismMock.swift
//  Sirius
//
//  Created by Giovani Nascimento Pereira on 24/08/18.
//  Copyright © 2018 Giovani Nascimento Pereira. All rights reserved.
//

import UIKit

class PacientMechanisMock {
    
    static func getPacient() -> Pacient {
        return DataMock.pacient
    }
    
    static func savePacient(_ pacient: Pacient) {}
    
    static func getPacientAppointments() -> [Appointment] {
        return DataMock.appointments
    }
    
    static func getWaitTime() -> Date {
        return Date(timeIntervalSinceNow: 3000)
    }
    
    static func updateAppointment(_ appointment: Appointment) {}
    
    private init() {}
    
}
