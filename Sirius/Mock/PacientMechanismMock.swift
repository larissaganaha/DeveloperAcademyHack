//
//  PacientMechanismMock.swift
//  Sirius
//
//  Created by Giovani Nascimento Pereira on 24/08/18.
//  Copyright © 2018 Giovani Nascimento Pereira. All rights reserved.
//

import UIKit

class PacientMechanisMock {
    
    static let pacient: Pacient = Pacient(ID: "123456789", name: "Pedro Ferreira", address: "Rua Maria do Carmo, Campinas, 13075-223", telephone: "(19)37199947", bornDate: Date(timeIntervalSinceNow: -630720000), height: 1.77, weight: 80.0, drink: true, hipertension: false, diabetes: false, smoking: false)
    
    static var appointments: [Appointment] = [
        Appointment(pacient: pacient, scheduledTime: Date(timeIntervalSinceNow: 5000), transcript: "", sinptomLog: DataLog(date: Date(), images: [], texts: []), reportLog: DataLog(date: Date(), images: [], texts: [])),
        
        Appointment(pacient: pacient, scheduledTime: Date(timeIntervalSinceNow: 5000), transcript: "", sinptomLog: DataLog(date: Date(), images: [], texts: []), reportLog: DataLog(date: Date(), images: [], texts: [])),
        
        Appointment(pacient: pacient, scheduledTime: Date(timeIntervalSinceNow: 5000), transcript: "", sinptomLog: DataLog(date: Date(), images: [], texts: []), reportLog: DataLog(date: Date(), images: [], texts: [])),
        
        Appointment(pacient: pacient, scheduledTime: Date(timeIntervalSinceNow: 5000), transcript: "", sinptomLog: DataLog(date: Date(), images: [], texts: []), reportLog: DataLog(date: Date(), images: [], texts: [])),
        
        Appointment(pacient: pacient, scheduledTime: Date(timeIntervalSinceNow: 5000), transcript: "", sinptomLog: DataLog(date: Date(), images: [], texts: []), reportLog: DataLog(date: Date(), images: [], texts: []))
    ]
    
    static func getPacient() -> Pacient {
        return pacient
    }
    
    static func savePacient(_ pacient: Pacient) {}
    
    static func getPacientAppointments() -> [Appointment] {
        return appointments
    }
    
    static func getWaitTime() -> Date {
        return Date(timeIntervalSinceNow: 3000)
    }
    
    private init() {}
    
}
