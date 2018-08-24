//
//  PacientMechanismFirebase.swift
//  Sirius
//
//  Created by Julianny Favinha on 8/24/18.
//  Copyright © 2018 Giovani Nascimento Pereira. All rights reserved.
//

import Foundation

class PacientFirebaseMechanism: FirebaseMechanism {
    static let shared = PacientFirebaseMechanism()
    
    private override init() {
        super.init()
    }
    
    func createPacient(ID: String, name: String, address: String, telephone: String, bornDate: Date, height: Double, weight: Double,
                       drink: Bool, hipertension: Bool, diabetes: Bool, smoking: Bool) {
        let newPacient = Pacient(ID: ID, name: name, address: address, telephone: telephone, bornDate: bornDate, height: height, weight: weight, drink: drink, hipertension: hipertension, diabetes: diabetes, smoking: smoking)
        
        let path = "Pacients"
        
        self.create(dump: Pacient.self, object: newPacient, path: path, newObjectID: ID)
    }
    
    func retrievePacient(id: String) {
        ref?.child("Pacients/\(id)").observeSingleEvent(of: .value, with: { (snapshot) in
            let pacient = snapshot.value as? NSDictionary
            
            if let actualPacient = pacient {
                if let newPacient = Pacient(dictionary: (actualPacient as? [AnyHashable: Any])!) {
                    // call delegate
                }
            }
        })
    }
}
