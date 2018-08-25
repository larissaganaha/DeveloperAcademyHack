//
//  LagTimeService.swift
//  Sirius
//
//  Created by Bianca Itiroko on 24/08/18.
//  Copyright © 2018 Giovani Nascimento Pereira. All rights reserved.
//

import Foundation

class LagTimeService {
    static func updateLagTime(lagTime: LagTime){
        LagTimeMechanismFirebase.shared.updateLagTime(newLagTime: lagTime)
    }
}
