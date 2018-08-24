//
//  PacientServiceProtocol.swift
//  Sirius
//
//  Created by Giovani Nascimento Pereira on 24/08/18.
//  Copyright © 2018 Giovani Nascimento Pereira. All rights reserved.
//

import Foundation

protocol PacientServiceProtocol {
    
    func getPacient() -> Pacient
    func savePaacient(_ pacient: Pacient)
    func getConsultaPacient() -> Appointment
    
}
