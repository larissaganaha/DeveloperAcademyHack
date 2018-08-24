//
//  Appointment.swift
//  Sirius
//
//  Created by Giovani Nascimento Pereira on 24/08/18.
//  Copyright © 2018 Giovani Nascimento Pereira. All rights reserved.
//

import UIKit

class Appointment: PersistenceObject {
    var pacient: Pacient
    var scheduledTime: Date
    var transcript: String
    var sinptomLog: DataLog
    var reportLog: DataLog
    var dictInfo: [AnyHashable: Any] = [:]
    
    init (pacient: Pacient, scheduledTime: Date, transcript: String, sinptomLog: DataLog, reportLog: DataLog) {
        self.pacient = pacient
        self.scheduledTime = scheduledTime
        self.transcript = transcript
        self.reportLog = reportLog
        self.sinptomLog  = sinptomLog
        
        self.dictInfo = [
            "ID": pacient.ID,
            "name": pacient.name,
            "address": pacient.address,
            "telephone": pacient.telephone,
            "bornDate": pacient.bornDate,
            "height": pacient.height,
            "weight": pacient.weight,
            "drink": pacient.drink,
            "hipertension": pacient.hipertension,
            "diabetes": pacient.diabetes,
            "smoking": pacient.smoking,
            "scheduledTime": scheduledTime,
            "transcript": transcript,
            "dateSinp": sinptomLog.date,
            "imagesSinp": sinptomLog.images,
            "textsSinp": sinptomLog.texts,
            "dateReport": reportLog.date,
            "imagesReport": reportLog.images,
            "textsReport": reportLog.texts
        ]
    }
    
    required init?(dictionary: [AnyHashable : Any]) {
        if  let scheduledTime = dictionary["scheduledTime"] as? Date,
            let transcript = dictionary["transcript"] as? String,
            let pacientID = dictionary["ID"] as? String,
            let name = dictionary["name"] as? String,
            let address = dictionary["address"] as? String,
            let telephone = dictionary["telephone"] as? String,
            let bornDate = dictionary["bornDate"] as? Date,
            let height = dictionary["height"] as? Double,
            let weight = dictionary["weight"] as? Double,
            let drink = dictionary["drink"] as? Bool,
            let hipertension = dictionary["hipertension"] as? Bool,
            let diabetes = dictionary["diabetes"] as? Bool,
            let smoking = dictionary["smoking"] as? Bool,
            let dateSinp = dictionary["dateSinp"] as? Date,
            let imagesSinp = dictionary["imagesSinp"] as? [String],
            let textsSinp = dictionary["textsSinp"] as? [String],
            let dateReport = dictionary["dateReport"] as? Date,
            let imagesReport = dictionary["imagesReport"] as? [String],
            let textsReport = dictionary["textsReport"] as? [String] {
            
            self.scheduledTime = scheduledTime
            self.transcript = transcript
            
            self.pacient = Pacient(ID: pacientID, name: name, address: address, telephone: telephone, bornDate: bornDate, height: height, weight: weight, drink: drink, hipertension: hipertension, diabetes: diabetes, smoking: smoking)
            
            self.reportLog = DataLog(date: dateReport, images: imagesReport, texts: textsReport)
            self.sinptomLog = DataLog(date: dateSinp, images: imagesSinp, texts: textsSinp)
            
            self.dictInfo = dictionary
        } else {
            print("Incomplete dictionary in Appointment object init")
            return nil
        }
    }
    
    func getDictInfo() -> [AnyHashable : Any] {
        return self.dictInfo
    }
}
