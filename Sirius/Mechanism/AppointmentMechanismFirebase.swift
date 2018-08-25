//
//  AppointmentMechanismFirebase.swift
//  Sirius
//
//  Created by Julianny Favinha on 8/24/18.
//  Copyright © 2018 Giovani Nascimento Pereira. All rights reserved.
//

import Foundation
import UIKit
import FirebaseStorage

class AppointmentMechanismFirebase: FirebaseMechanism {
    static let shared = AppointmentMechanismFirebase()
    let path: String = "Appointments"
    
    private override init() {
        super.init()
    }
    
    func createAppointment(appointment: Appointment) {
        self.create(dump: Appointment.self, object: appointment, path: path, newObjectID: appointment.id)
    }
    
//    func retrieveAppointment(id: String, completionHandler: @escaping (Appointment?) -> Void) {
//        self.retrieve(dump: Appointment.self, path: "Appointments/\(id)") { (appointments) in
//            completionHandler(appointments?.first)
//        }
//
////        ref?.child("Appointments/\(id)").observeSingleEvent(of: .value, with: { (snapshot) in
////            let appointment = snapshot.value as? NSDictionary
////
////            if let actualAppointment = appointment {
////                if let newAppointment = Appointment(dictionary: (actualAppointment as? [AnyHashable: Any])!) {
////                    completionHandler(newAppointment)
////                }
////            } else {
////                completionHandler(nil)
////            }
////        })
//    }
    
    func retrieveAppointments(from pacientID: String, completionHandler: @escaping ([Appointment]?) -> Void) {
        self.retrieve(dump: Appointment.self, path: path) { (appointments) in
            let pacientsAppoints = appointments?.filter{$0.pacient.ID == pacientID}
            
            completionHandler(pacientsAppoints)
        }
    }
    
    func retrieveAllActiveAppointments(completionHandler: @escaping ([Appointment]?) -> Void) {
        self.retrieve(dump: Appointment.self, path: path) { (appointments) in
            let activeAppointments = appointments?.filter { $0.isActive }
            completionHandler(activeAppointments)
        }
    }
}
