//
//  Appointment.swift
//  Sirius
//
//  Created by Giovani Nascimento Pereira on 24/08/18.
//  Copyright © 2018 Giovani Nascimento Pereira. All rights reserved.
//

import UIKit

class Appointment: PersistenceObject {
    var id: String = ""
    var pacient: Pacient = Pacient()
    var scheduledTime: Date = Date()
    var transcript: String = ""
    var sinptomLog: DataLog?
    var reportLog: DataLog?
    var isActive: Bool = true
    var dictInfo: [AnyHashable: Any] = [:]
    
    init (pacient: Pacient, scheduledTime: Date, transcript: String, sinptomLog: DataLog?, reportLog: DataLog?) {
        self.pacient = pacient
        self.scheduledTime = scheduledTime
        self.transcript = transcript
        self.reportLog = reportLog
        self.sinptomLog  = sinptomLog
        
        self.dictInfo = [
            "ID": pacient.ID,
            "id": id,
            "name": pacient.name,
            "address": pacient.address,
            "telephone": pacient.telephone,
            "bornDate": pacient.bornDate.toString(dateFormat: "dd-MM-yyyy"),
            "height": pacient.height,
            "weight": pacient.weight,
            "drink": pacient.drink,
            "hipertension": pacient.hipertension,
            "diabetes": pacient.diabetes,
            "smoking": pacient.smoking,
            "scheduledTime": scheduledTime.toString(dateFormat: "dd-MM-yyyy"),
            "transcript": transcript,
            "isActive": true
        ]
        
        if pacient.imageURL != nil {
            self.dictInfo["imageURL"] = pacient.imageURL
        }
        
        if let sinptomLog = sinptomLog {
            self.dictInfo["dateSinp"] = sinptomLog.date.toString(dateFormat: "dd-MM-yyyy")
            self.dictInfo["imagesSinp"] = sinptomLog.images
            self.dictInfo["textsSinp"] = sinptomLog.texts
        }
        
        if let reportLog = reportLog {
            self.dictInfo["dateReport"] = reportLog.date.toString(dateFormat: "dd-MM-yyyy")
            self.dictInfo["imagesReport"] = reportLog.images
            self.dictInfo["textsReport"] = reportLog.texts
        }
    }
    
    required init?(dictionary: [AnyHashable : Any]) {
        if let transcript = dictionary["transcript"] as? String,
            let pacientID = dictionary["ID"] as? String,
            let name = dictionary["name"] as? String,
            let address = dictionary["address"] as? String,
            let telephone = dictionary["telephone"] as? String,
            let height = dictionary["height"] as? Double,
            let weight = dictionary["weight"] as? Double,
            let drink = dictionary["drink"] as? Bool,
            let hipertension = dictionary["hipertension"] as? Bool,
            let diabetes = dictionary["diabetes"] as? Bool,
            let smoking = dictionary["smoking"] as? Bool,
            let id = dictionary["id"] as? String {
            
            self.id = id
            
            if let sched = dictionary["scheduledTime"] as? String {
                if let schedTime = self.formatDate(date: sched) {
                    self.scheduledTime = schedTime
                } else {
                    self.scheduledTime = Date()
                }
            }
            
            guard let bDateString = dictionary["bornDate"] as? String  else { return }
            
            if let bDateDate = self.formatDate(date: bDateString) {
                self.pacient.bornDate = bDateDate
            } else {
                self.pacient.bornDate = Date()
            }
            
            self.transcript = transcript
            
            self.pacient = Pacient(ID: pacientID, name: name, address: address, telephone: telephone, imageURL: nil, bornDate: self.pacient.bornDate, height: height, weight: weight, drink: drink, hipertension: hipertension, diabetes: diabetes, smoking: smoking)
            
            if let imageURL = dictionary["imageURL"] as? String {
                self.pacient.imageURL = imageURL
            }
            
            guard let dSinpString = dictionary["dateSinp"] as? String else { return }
            var dateSinp: Date = Date()
            
            if let dSinpDate = self.formatDate(date: dSinpString) {
                 dateSinp = dSinpDate
            }
            
            if let imagesSinp = dictionary["imagesSinp"] as? [String],
                let textsSinp = dictionary["textsSinp"] as? [String] {
                self.sinptomLog = DataLog(date: dateSinp, images: imagesSinp, texts: textsSinp)
            }
            
            guard let dReportString = dictionary["dateReport"] as? String else { return }
            var dateReport: Date = Date()
            
            if let dReportDate = self.formatDate(date: dReportString) {
                dateReport = dReportDate
            }
            
            if let imagesReport = dictionary["imagesReport"] as? [String],
                let textsReport = dictionary["textsReport"] as? [String] {
                self.reportLog = DataLog(date: dateReport, images: imagesReport, texts: textsReport)
            }
            
            self.isActive = true
            
            self.dictInfo = dictionary
        } else {
            print("Incomplete dictionary in Appointment object init")
            return nil
        }
    }
    
    func getDictInfo() -> [AnyHashable : Any] {
        return self.dictInfo
    }
    
    func formatDate(date: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        
        if let formattedDate = dateFormatter.date(from: date) {
            return formattedDate
        } else {
            return nil
        }
    }
}
