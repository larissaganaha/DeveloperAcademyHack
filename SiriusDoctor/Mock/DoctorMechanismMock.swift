//
//  DoctorMechanismMock.swift
//  SiriusDoctor
//
//  Created by Giovani Nascimento Pereira on 24/08/18.
//  Copyright © 2018 Giovani Nascimento Pereira. All rights reserved.
//

import Foundation

class DoctorMechanismMock {
    
    static func getAppointments() -> [Appointment] {
        return DataMock.doctorAppointments
    }
    
    static func saveAppointment(_ appointment: Appointment) {}
    
    static func getPacient(id: String) -> Pacient {
        return DataMock.doctorPacients.filter({$0.ID == id}).first ?? DataMock.pacient
    }
    
}
