//
//  Pacient.swift
//  Sirius
//
//  Created by Giovani Nascimento Pereira on 24/08/18.
//  Copyright © 2018 Giovani Nascimento Pereira. All rights reserved.
//

import UIKit

class Pacient: PersistenceObject {
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
    
    // Persistence things
    var dictInfo: [AnyHashable: Any] = [:]
    
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
        
        self.dictInfo = [
            "ID": ID,
            "name": name,
            "address": address,
            "telephone": telephone,
            "bornDate": bornDate,
            "height": height,
            "weight": weight,
            "drink": drink,
            "hipertension": hipertension,
            "diabetes": diabetes,
            "smoking": smoking
        ]
    }
    
    convenience init() {
        self.init(ID: "12345", name: "", address: "", telephone: "", bornDate: Date(), height: 1.50, weight: 60.0, drink: false, hipertension: false, diabetes: false, smoking: false)
    }
    
    required init?(dictionary: [AnyHashable : Any]) {
        if  let id = dictionary["ID"] as? String,
            let name = dictionary["name"] as? String,
            let address = dictionary["address"] as? String,
            let telephone = dictionary["telephone"] as? String,
            let bornDate = dictionary["bornDate"] as? Date,
            let height = dictionary["height"] as? Double,
            let weight = dictionary["weight"] as? Double,
            let drink = dictionary["drink"] as? Bool,
            let hipertension = dictionary["hipertension"] as? Bool,
            let diabetes = dictionary["diabetes"] as? Bool,
            let smoking = dictionary["smoking"] as? Bool {
            
            self.ID = id
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
            
            self.dictInfo = dictionary
        } else {
            print("Dictionary incomplete to create User object")
            return nil
        }
    }
    
    func getDictInfo() -> [AnyHashable : Any] {
        return self.dictInfo
    }
    
}
