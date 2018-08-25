//
//  LagTimeMechanismFirebase.swift
//  Sirius
//
//  Created by Bianca Itiroko on 24/08/18.
//  Copyright © 2018 Giovani Nascimento Pereira. All rights reserved.
//

import Foundation
import Firebase

class LagTimeMechanismFirebase: FirebaseMechanism {
    static let shared = LagTimeMechanismFirebase()
    let path: String = "LagTime"
    
    private override init() {
        super.init()
    }
    
    func updateLagTime(newLagTime: LagTime) {
        let dict = newLagTime.getDictInfo()
        ref?.child(path).setValue(dict)
    }
    
    func addObserverEventAdded(completion: @escaping (Int?) -> Void){
        self.ref?.child("LagTime").observe(.childChanged, with: { (snapshot) in
            completion(snapshot.value as? Int)
        })
    }
    
    func getLagTime(completion: @escaping (Int?) -> Void) {
        self.retrieve(dump: LagTime.self, path: "LagTime") { (lagTime) in
            completion(lagTime?.first?.lagTime)
        }
    }
}
