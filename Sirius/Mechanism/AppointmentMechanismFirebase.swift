//
//  AppointmentMechanismFirebase.swift
//  Sirius
//
//  Created by Julianny Favinha on 8/24/18.
//  Copyright © 2018 Giovani Nascimento Pereira. All rights reserved.
//

import Foundation

class AppointmentMechanismFirebase: FirebaseMechanism {
    static let shared = AppointmentMechanismFirebase()
    
    private override init() {
        super.init()
    }
    
    func createAppointment(pacient: Pacient, scheduledTime: Date, transcript: String, sinptomLog: DataLog, reportLog: DataLog) {
        let newAppointment = Appointment(pacient: pacient, scheduledTime: scheduledTime, transcript: transcript, sinptomLog: sinptomLog, reportLog: reportLog)
        
        let path = "Appointments"
        
        self.create(dump: Appointment.self, object: newAppointment, path: path, newObjectID: nil)
    }
    
    func retrieveAppointment(id: String) {
        ref?.child("Appointments/\(id)").observeSingleEvent(of: .value, with: { (snapshot) in
            let appointment = snapshot.value as? NSDictionary
            
            if let actualAppointment = appointment {
                if let newAppointment = Appointment(dictionary: (actualAppointment as? [AnyHashable: Any])!) {
                    // call delegate
                }
            }
        })
    }
}
