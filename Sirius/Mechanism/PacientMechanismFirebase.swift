//
//  PacientMechanismFirebase.swift
//  Sirius
//
//  Created by Julianny Favinha on 8/24/18.
//  Copyright © 2018 Giovani Nascimento Pereira. All rights reserved.
//

import Foundation
import UIKit
import FirebaseStorage

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
        self.retrieve(dump: Pacient.self, path: "Pacients/\(id)") { (pacient) in
            completionHandler(pacient?.first)
        }
//        ref?.child("Pacients/\(id)").observeSingleEvent(of: .value, with: { (snapshot) in
//            let pacient = snapshot.value as? NSDictionary
//
//            if let actualPacient = pacient {
//                if let newPacient = Pacient(dictionary: (actualPacient as? [AnyHashable: Any])!) {
//                    completionHandler(newPacient)
//                }
//            } else {
//                completionHandler(nil)
//            }
//        })
    }
    
    func uploadImage(profileImage: UIImage, pacientID: String, completionHandler: @escaping (String?) -> Void) {
        
        let imageName = NSUUID.init()
        let storageRef = Storage.storage().reference().child("\(imageName).png")
        
        if let uploadData = UIImagePNGRepresentation(profileImage) {
            storageRef.putData(uploadData, metadata: nil, completion: { (metadata, error) in
                if error == nil {
                    
                    storageRef.downloadURL(completion: { (url, error) in
                        guard let downloadURL = url else {
                            return
                        }
                        completionHandler(downloadURL.absoluteString)
                    })
                } else {
                    print(error.debugDescription)
                }
            })
        }
    }
}
