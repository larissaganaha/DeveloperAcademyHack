//
//  DataMock.swift
//  Sirius
//
//  Created by Giovani Nascimento Pereira on 24/08/18.
//  Copyright © 2018 Giovani Nascimento Pereira. All rights reserved.
//

import Foundation

class DataMock {
    
    static let pacient: Pacient = Pacient(ID: "123456789", name: "Pedro Ferreira", address: "Rua Maria do Carmo, Campinas, 13075-223", telephone: "(19)37199947", bornDate: Date(timeIntervalSinceNow: -630720000), height: 1.77, weight: 80.0, drink: true, hipertension: false, diabetes: false, smoking: false)
    
    static var appointments: [Appointment] = [
        Appointment(pacient: pacient, scheduledTime: Date(timeIntervalSinceNow: 5000), transcript: "", sinptomLog: DataLog(date: Date(), images: [], texts: ["dor de cabeça", "dor de estômago", "coceira intermitente"]), reportLog: DataLog(date: Date(), images: [], texts: [])),
        
        Appointment(pacient: pacient, scheduledTime: Date(timeIntervalSinceNow: 17000), transcript: "", sinptomLog: DataLog(date: Date(), images: [], texts: ["tosse aguda"]), reportLog: DataLog(date: Date(), images: [], texts: [])),
        
        Appointment(pacient: pacient, scheduledTime: Date(timeIntervalSinceNow: 72000), transcript: "", sinptomLog: DataLog(date: Date(), images: [], texts: ["vermelhidão na pele", "suando frio"]), reportLog: DataLog(date: Date(), images: [], texts: [])),
        
        Appointment(pacient: pacient, scheduledTime: Date(timeIntervalSinceNow: 90000), transcript: "", sinptomLog: DataLog(date: Date(), images: [], texts: ["dor de estômago"]), reportLog: DataLog(date: Date(), images: [], texts: [])),
        
        Appointment(pacient: pacient, scheduledTime: Date(timeIntervalSinceNow: 130000), transcript: "", sinptomLog: DataLog(date: Date(), images: [], texts: ["bati o pé gente olha que horror!"]), reportLog: DataLog(date: Date(), images: [], texts: []))
    ]
    
    
    
}
