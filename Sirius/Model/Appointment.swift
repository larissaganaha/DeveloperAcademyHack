//
//  Appointment.swift
//  Sirius
//
//  Created by Giovani Nascimento Pereira on 24/08/18.
//  Copyright © 2018 Giovani Nascimento Pereira. All rights reserved.
//

import UIKit

class Appointment {
    var pacient: Pacient
    var scheduledTime: Date
    var transcript: String
    var sinptomLog: DataLog
    var reportLog: DataLog
    
    init (pacient: Pacient, scheduledTime: Date, transcript: String, sinptomLog: DataLog, reportLog: DataLog) {
        self.pacient = pacient
        self.scheduledTime = scheduledTime
        self.transcript = transcript
        self.reportLog = reportLog
        self.sinptomLog  = sinptomLog
    }
    
}
