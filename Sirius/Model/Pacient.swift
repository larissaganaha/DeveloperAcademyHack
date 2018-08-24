//
//  Pacient.swift
//  Sirius
//
//  Created by Giovani Nascimento Pereira on 24/08/18.
//  Copyright © 2018 Giovani Nascimento Pereira. All rights reserved.
//

import UIKit

class Pacient {
    
    var ID: String
    
    // Personal Info
    var name: String
    var address: String
    var telephone: String
    
    // Body info
    var bornDate: Date
    var height: Double
    var weight: Double
    var age: Double {
        return Date().timeIntervalSince(bornDate)
    }
    
    // Medical info
    var drink: Bool
    var hipertension: Bool
    var diabetes: Bool
    var smoking: Bool
    
    init(ID: String, name: String, address: String, telephone: String, bornDate: Date, height: Double, weight: Double, drink: Bool, hipertension: Bool, diabetes: Bool, smoking: Bool) {
        self.ID = ID
        self.name = name
        self.address = address
        self.telephone = telephone
        self.bornDate = bornDate
        self.height = height
        self.weight = weight
        
        self.drink = drink
        self.hipertension = hipertension
        self.diabetes = diabetes
        self.smoking = smoking
    }
    
}
