//
//  AppointmentService.swift
//  Sirius
//
//  Created by Bianca Itiroko on 24/08/18.
//  Copyright © 2018 Giovani Nascimento Pereira. All rights reserved.
//

import UIKit

class AppointmentService: NSObject {
    //
//    func getAppointment(id: String, completionHandler: @escaping (Appointment?) -> Void) {
//        AppointmentMechanismFirebase.shared.retrieveAppointment(id: id, completionHandler: completionHandler)
//    }
    
    //Chamamos quando o médico coloca mais dados (voz) ou o paciente coloca os logs
    func saveAppointment(_ appointment: Appointment) {
        AppointmentMechanismFirebase.shared.createAppointment(appointment: appointment)
    }
    
    //Chamamos para pegar todos os appointments de um paciente (na interface paciente)
    func getAppointments(from pacientID: String, completionHandler: @escaping ([Appointment]?) -> Void) {
        AppointmentMechanismFirebase.shared.retrieveAppointments(from: pacientID, completionHandler: completionHandler)
    }
    
    //Chamamos quando o médico quer ver todos os appointments
    func getAllActiveAppointments(completionHandler: @escaping ([Appointment]?) -> Void) {
        AppointmentMechanismFirebase.shared.retrieveAllActiveAppointments(completionHandler: completionHandler)
    }
}
