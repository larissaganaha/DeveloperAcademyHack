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
    
    func createPacient(pacient: Pacient) {
        
        let path = "Pacients"
        
        self.create(dump: Pacient.self, object: pacient, path: path, newObjectID: pacient.ID)
    }
    
    func retrievePacient(id: String, completionHandler: @escaping (Pacient?) -> Void) {
        ref?.child("Pacients/\(id)").observeSingleEvent(of: .value, with: { (snapshot) in
            let pacient = snapshot.value as? NSDictionary
            
            if let actualPacient = pacient {
                if let newPacient = Pacient(dictionary: (actualPacient as? [AnyHashable: Any])!) {
                    completionHandler(newPacient)
                }
            } else {
                completionHandler(nil)
            }
        })
    }
}
