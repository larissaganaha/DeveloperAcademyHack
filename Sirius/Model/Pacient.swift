//
//  Pacient.swift
//  Sirius
//
//  Created by Giovani Nascimento Pereira on 24/08/18.
//  Copyright © 2018 Giovani Nascimento Pereira. All rights reserved.
//

import UIKit

class Pacient: NSObject, PersistenceObject {
    var ID: String = ""
    
    // Personal Info
    var name: String = ""
    var address: String = ""
    var telephone: String = ""
    var imageURL: String?
    
    // Body info
    var bornDate: Date = Date()
    var height: Double = 1.0
    var weight: Double = 1.0
    var age: Double {
        return Date().timeIntervalSince(bornDate) / (3600*24*365)
    }
    
    var realURL: URL? {
        return URL(string: imageURL ?? "")
    }
    
    var personalInfo: String {
        return "Peso: \(weight)\t| Altura: \(height)\nIdade: \(Int(age))\n" +
        "\(drink ? "Alcoolismo \n" : "")" +
        "\(smoking ? "Tabagismo \n" : "")" +
        "\(diabetes ? "Diabético \n" : "")"
    }
    
    var familyHistory: String {
        return "\(hipertension ? "Hipertensão \n" : "")" +
        "\(diabetes ? "Diabetes \n" : "")"
    }
    
    var medicines: String {
        return " - "
    }
    
    // Medical info
    var drink: Bool = false
    var hipertension: Bool = false
    var diabetes: Bool = false
    var smoking: Bool = false
    
    // Persistence things
    var dictInfo: [AnyHashable: Any] = [:]
    
    init(ID: String, name: String, address: String, telephone: String, imageURL:String?, bornDate: Date, height: Double, weight: Double, drink: Bool, hipertension: Bool, diabetes: Bool, smoking: Bool) {
        self.ID = ID
        self.name = name
        self.address = address
        self.telephone = telephone
        self.imageURL = imageURL
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
            "bornDate": bornDate.toString(dateFormat: "yyyy/MM/dd"),
            "height": height,
            "weight": weight,
            "drink": drink,
            "hipertension": hipertension,
            "diabetes": diabetes,
            "smoking": smoking
        ]
        
        if imageURL != nil {
            self.dictInfo["imageURL"] = imageURL
        }
    }
    
    override init () {
        super.init()
    }
    
    required init?(dictionary: [AnyHashable : Any]) {
        super.init()
        
        if  let ID = dictionary["ID"] as? String,
            let name = dictionary["name"] as? String,
            let address = dictionary["address"] as? String,
            let telephone = dictionary["telephone"] as? String,
            let height = dictionary["height"] as? Double,
            let weight = dictionary["weight"] as? Double,
            let drink = dictionary["drink"] as? Bool,
            let hipertension = dictionary["hipertension"] as? Bool,
            let diabetes = dictionary["diabetes"] as? Bool,
            let smoking = dictionary["smoking"] as? Bool {
            
            self.ID = ID
            self.name = name
            self.address = address
            self.telephone = telephone
            self.height = height
            self.weight = weight
            self.drink = drink
            self.hipertension = hipertension
            self.diabetes = diabetes
            self.smoking = smoking
            self.dictInfo = dictionary
            
            if let imageURL = dictionary["imageURL"] as? String {
                self.imageURL = imageURL
            }
            
            if let born = dictionary["bornDate"] as? String {
                if let bDate = self.formatDate(date: born) {
                    self.bornDate = bDate
                } else {
                    self.bornDate = Date()
                }
            }
        } else {
            print("Dictionary incomplete to create Pacient object")
            return nil
        }
    }
    
    func getDictInfo() -> [AnyHashable : Any] {
        return self.dictInfo
    }
    
    func formatDate(date: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        
        if let formattedDate = dateFormatter.date(from: date) {
            return formattedDate
        } else {
            return nil
        }
    }
}

extension Date {
    func toString(dateFormat format  : String ) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
}
