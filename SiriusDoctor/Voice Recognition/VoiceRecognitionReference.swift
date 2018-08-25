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
        "tosse", "dor de cabeça", "dor de ouvido", "diarréia", "tremedeira", "braço quebrado", "dor intermitente", "dor aguda", "secreção", "catarro", "tosse seca", "vermelhidão", "roxo", "coceira", "perda de cabelo", "perca de cabelo", "visão laser", "dor nas costas", "olhos vermelhos", "lágrima", "olho lacrimejando", "dor nas juntas", "dor no joelho", "dor nos joelhos", "visão embaçada", "vista embaçada", "visão turva", "dificuldade de respirar", "respiração forçada", "língua presa", "sangue", "nariz sangrando", "sangramento nasal", "alergia", "muito sensível", "hipersensibilidade", "dor nos olhos", "melanoma", "mancha na pele", "carcinoma", "cegueira", "tontura", "desequilíbrio", "mancar", "unhas quebradiças", "sangue no nariz", "sangramento nasal", "nariz sangrando", "dormente", "ansiedade", "angústia", "apneia", "parada respiratória total", "atrofia", "aumento de peso", "edema", "hérnia", "fadiga", "cegueira", "depressão", "descamação da pele", "desmaio", "distonia", "emagrecimento", "engasgo", "espasmo", "euforia", "falta de ar", "febre", "ferimento", "fobia", "formigamento", "gagueira", "mau hálito", "hematomas", "perda de apetite", "insônia", "mudez", "náusea", "paladar alterado", "palidez", "perda de memória", "pesadelo", "ronco", "rouquidão", "sede", "sonambulismo", "sonolência", "sudorese", "surdez", "tensão", "tontura", "tremor", "vertigem", "vômito", "zumbido"
    ]
    
    static let medicines: [String] = [
        "cetoconazol", "xarope", "placebo", "amoxilina", "caminhada", "corrida", "natação", "chá", "pomada", "maracujá", "paracetamol", "analgésico", "fisioterapia", "ginástica", "rinossoro", "tala", "gesso", "engessar", "terapia", "acompanhamento psicológico", "anti inflamatório", "anti térmico", "anti-inflamatório", "anti-térmico", "antinflamatório", "antitérmico", "dipirona", "nimelisuda", "antibiótico", "naproxeno", "folic", "anticoncepcional", "contraceptivo", "vitamina c", "vitamina a", "vitamina b", "vitamina d", "complexo vitamínico", "ibuprofeno", "ibufran", "jumexil", "água", "pilates", "alimentação saudável", "academia", "fitoterápico", "homeopatia"
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
