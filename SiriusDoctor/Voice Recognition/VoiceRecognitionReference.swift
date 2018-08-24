//
//  VoiceRecognitionReference.swift
//  SiriusDoctor
//
//  Created by Giovani Nascimento Pereira on 24/08/18.
//  Copyright © 2018 Giovani Nascimento Pereira. All rights reserved.
//

import Foundation

class VoiceRecognitionReference {
    
    static let simptoms: [String] = [
        "tosse", "dor de cabeça", "dor de ouvido", "diarréia", "tremedeira", "braço quebrado", "dor intermitente", "dor aguda", "secreção", "catarro", "tosse seca"
    ]
    
    static let medicines: [String] = [
        "cetoconazol", "xarope", "placebo", "amoxilina", "caminhada", "corrida", "natação"
    ]
    
    static func identifySimptoms(from text: String) -> [String] {
        var findings: [String] = []
        for simptom in self.simptoms {
            if (text.lowercased().range(of: simptom.lowercased()) != nil) {
                findings.append(simptom)
            }
        }
        return findings
    }
    
    static func identifyMedicines(from text: String) -> [String] {
        var findings: [String] = []
        for medicine in self.medicines {
            if (text.lowercased().range(of: medicine.lowercased()) != nil) {
                findings.append(medicine)
            }
        }
        return findings
    }
    
    
}
