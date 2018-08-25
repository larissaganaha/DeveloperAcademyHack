//
//  LagTimeMechanismFirebase.swift
//  Sirius
//
//  Created by Bianca Itiroko on 24/08/18.
//  Copyright © 2018 Giovani Nascimento Pereira. All rights reserved.
//

import Foundation

class LagTimeMechanismFirebase: FirebaseMechanism {
    static let shared = LagTimeMechanismFirebase()
    let path: String = "LagTime"
    
    private override init() {
        super.init()
    }
    
    func updateLagTime(newLagTime: LagTime) {
        var dict = newLagTime.getDictInfo()
        ref?.child(path).setValue(dict)
    }
}
