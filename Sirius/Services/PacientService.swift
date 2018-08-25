//
//  PacientService.swift
//  Sirius
//
//  Created by Giovani Nascimento Pereira on 24/08/18.
//  Copyright © 2018 Giovani Nascimento Pereira. All rights reserved.
//

import Foundation
import UIKit

class PacientService: PacientServiceProtocol {
    
    func getPacient(id: String, completionHandler: @escaping (Pacient?) -> Void) {
        PacientFirebaseMechanism.shared.retrievePacient(id: id, completionHandler: completionHandler)
    }
    
    func getAllPacients(completionHandler: @escaping ([Pacient]?) -> Void) {
        PacientFirebaseMechanism.shared.retrieveAllPacients(completionHandler: completionHandler)
    }
    
    func savePacient(_ pacient: Pacient) {
        PacientFirebaseMechanism.shared.createPacient(pacient: pacient)
//        PacientMechanisMock.savePacient(pacient)
    }
    
    func getWaitTime() -> Date {
        return PacientMechanisMock.getWaitTime()
    }
    
    func uploadProfilePhoto(image: UIImage, pacientID: String, completion: @escaping (String?) -> Void){
        PacientFirebaseMechanism.shared.uploadImage(profileImage: image, pacientID: pacientID) { (string) in
            if string == nil {
                print("deu ruim pra subir a foto")
            }
            completion(string)
        }
    }
}
