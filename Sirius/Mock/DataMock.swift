//
//  DataMock.swift
//  Sirius
//
//  Created by Giovani Nascimento Pereira on 24/08/18.
//  Copyright © 2018 Giovani Nascimento Pereira. All rights reserved.
//

import Foundation

class DataMock {
    
    
    // Pacient Mock
    static let pacient: Pacient = Pacient(ID: "123456789", name: "Pedro Ferreira", address: "Rua Maria do Carmo, Campinas, 13075-223", telephone: "(19)37199947", imageURL: nil, bornDate: Date(timeIntervalSinceNow: -630720000), height: 1.77, weight: 80.0, drink: true, hipertension: false, diabetes: false, smoking: false)
    
    static var appointments: [Appointment] = [
        Appointment(id: UUID().uuidString, pacient: pacient, scheduledTime: Date(timeIntervalSinceNow: 5000), transcript: "", sinptomLog: DataLog(date: Date(), images: ["https://static.tuasaude.com/media/article/vm/bm/alergia-a-agua_28080_l.jpg", "https://static.tuasaude.com/media/article/aa/db/alergia-na-pele_15424_l.jpg", "https://www.fotosantesedepois.com/wp-content/uploads/2014/07/Sintomas-de-Alergia-ao-Sol.jpg", "https://www.saludconsultas.com/wp-content/uploads/2018/03/Alergias-avicolas.jpg", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRnQzUOocKwaE7B8H9Gv4QxC4xMuwtcVyjmIThnLwSS06LF6oJk"], texts: ["dor de cabeça", "dor de estômago", "coceira intermitente"]), reportLog: DataLog(date: Date(), images: ["https://i.imgur.com/Ju7VXkh.jpg"], texts: [])),
        
        Appointment(id: UUID().uuidString, pacient: pacient, scheduledTime: Date(timeIntervalSinceNow: 17000), transcript: "", sinptomLog: DataLog(date: Date(), images: [], texts: ["tosse aguda"]), reportLog: DataLog(date: Date(), images: [], texts: [])),
        
        Appointment(id: UUID().uuidString, pacient: pacient, scheduledTime: Date(timeIntervalSinceNow: 72000), transcript: "", sinptomLog: DataLog(date: Date(), images: [], texts: ["vermelhidão na pele", "suando frio"]), reportLog: DataLog(date: Date(), images: [], texts: [])),
        
        Appointment(id: UUID().uuidString, pacient: pacient, scheduledTime: Date(timeIntervalSinceNow: 90000), transcript: "", sinptomLog: DataLog(date: Date(), images: [], texts: ["dor de estômago"]), reportLog: DataLog(date: Date(), images: [], texts: [])),
        
        Appointment(id: UUID().uuidString, pacient: pacient, scheduledTime: Date(timeIntervalSinceNow: 130000), transcript: "", sinptomLog: DataLog(date: Date(), images: [], texts: ["bati o pé gente olha que horror!"]), reportLog: DataLog(date: Date(), images: [], texts: []))
    ]
    
    // Doctor Mock
    static let doctorPacients: [Pacient] = [
    
        DataMock.pacient,
        
        Pacient(ID: "123456789", name: "Pedro Ferreira", address: "Rua Maria do Carmo, Campinas, 13075-223", telephone: "(19)3781716747", imageURL: nil, bornDate: Date(timeIntervalSinceNow: -630720000), height: 1.77, weight: 80.0, drink: true, hipertension: false, diabetes: false, smoking: false),
        
        Pacient(ID: "123456789", name: "Maria do Carmo", address: "Rua Maria Gasola, São Paulo, 13075-223", telephone: "(19)343499947", imageURL: nil, bornDate: Date(timeIntervalSinceNow: -930720000), height: 1.55, weight: 70.0, drink: true, hipertension: false, diabetes: true, smoking: true),
        
        Pacient(ID: "123456789", name: "Felipe Scarpirita", address: "Rua Maria do Carmo, Campinas, 13075-223", telephone: "(19)97324947", imageURL: nil, bornDate: Date(timeIntervalSinceNow: -430720000), height: 1.60, weight: 92.0, drink: true, hipertension: true, diabetes: false, smoking: false),
        
        Pacient(ID: "123456789", name: "Marília Mendonça", address: "Rua Maria do Carmo, Campinas, 13075-223", telephone: "(19)97324947", imageURL: nil, bornDate: Date(timeIntervalSinceNow: -430720000), height: 1.70, weight: 88.0, drink: true, hipertension: false, diabetes: true, smoking: false),
        
        Pacient(ID: "123456789", name: "Carmem Miranda Lúcia de Souza", address: "Rua Maria do Carmo, Campinas, 13075-223", telephone: "(19)97324947", imageURL: nil, bornDate: Date(timeIntervalSinceNow: -430720000), height: 1.66, weight: 30.0, drink: false, hipertension: true, diabetes: false, smoking: false)
        
    ]
    
    static var doctorAppointments: [Appointment] = [
        Appointment(id: UUID().uuidString, pacient: doctorPacients[0], scheduledTime: Date(timeIntervalSinceNow: 5000), transcript: "", sinptomLog: DataLog(date: Date(), images: [], texts: ["dor de cabeça", "dor de estômago", "coceira intermitente"]), reportLog: DataLog(date: Date(), images: [], texts: [])),
        
        Appointment(id: UUID().uuidString, pacient: doctorPacients[1], scheduledTime: Date(timeIntervalSinceNow: 17000), transcript: "", sinptomLog: DataLog(date: Date(), images: [], texts: ["tosse aguda"]), reportLog: DataLog(date: Date(), images: [], texts: [])),
        
        Appointment(id: UUID().uuidString, pacient: doctorPacients[2], scheduledTime: Date(timeIntervalSinceNow: 72000), transcript: "", sinptomLog: DataLog(date: Date(), images: [], texts: ["vermelhidão na pele", "suando frio"]), reportLog: DataLog(date: Date(), images: [], texts: [])),
        
        Appointment(id: UUID().uuidString, pacient: doctorPacients[3], scheduledTime: Date(timeIntervalSinceNow: 90000), transcript: "", sinptomLog: DataLog(date: Date(), images: [], texts: ["dor de estômago"]), reportLog: DataLog(date: Date(), images: [], texts: [])),
        
        Appointment(id: UUID().uuidString, pacient: doctorPacients[4], scheduledTime: Date(timeIntervalSinceNow: 130000), transcript: "", sinptomLog: DataLog(date: Date(), images: [], texts: ["bati o pé gente olha que horror!"]), reportLog: DataLog(date: Date(), images: [], texts: []))
    ]
    
    
}
