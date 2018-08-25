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
        "tosse", "dor de cabeça", "dor de ouvido", "diarréia", "tremedeira", "braço quebrado", "dor intermitente", "dor aguda", "secreção", "catarro", "tosse seca", "vermelhidão", "roxo", "coceira", "perda de cabelo", "perca de cabelo", "visão laser", "dor nas costas", "olhos vermelhos", "lágrima", "olho lacrimejando", "dor nas juntas", "dor no joelho", "dor nos joelhos", "visão embaçada", "vista embaçada", "visão turva", "dificuldade de respirar", "respiração forçada", "língua presa", "sangue", "nariz sangrando", "sangramento nasal", "alergia", "muito sensível", "hipersensibilidade", "dor nos olhos", "melanoma", "mancha na pele", "carcinoma"
    ]
    
    static let medicines: [String] = [
        "cetoconazol", "xarope", "placebo", "amoxilina", "caminhada", "corrida", "natação", "chá", "pomada", "maracujá"
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
