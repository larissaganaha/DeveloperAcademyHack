//
//  PacientService.swift
//  Sirius
//
//  Created by Giovani Nascimento Pereira on 24/08/18.
//  Copyright © 2018 Giovani Nascimento Pereira. All rights reserved.
//

import Foundation

class PacientService: PacientServiceProtocol {
    
    func getPacient(id: String, completionHandler: @escaping (Pacient?) -> Void) {
        PacientFirebaseMechanism.shared.retrievePacient(id: id, completionHandler: completionHandler)
    }
    
    func savePacient(_ pacient: Pacient) {
        PacientFirebaseMechanism.shared.createPacient(pacient: pacient)
//        PacientMechanisMock.savePacient(pacient)
    }
    
    func getWaitTime() -> Date {
        return PacientMechanisMock.getWaitTime()
    }
    
}
