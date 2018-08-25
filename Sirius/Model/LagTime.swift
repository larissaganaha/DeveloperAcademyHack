//
//  LagTime.swift
//  Sirius
//
//  Created by Bianca Itiroko on 24/08/18.
//  Copyright © 2018 Giovani Nascimento Pereira. All rights reserved.
//

import Foundation

class LagTime: PersistenceObject {
    var lagTime: Int = 0
    var dictInfo: [AnyHashable: Any] = [:]
    
    init(lagTime: Int) {
        self.lagTime = lagTime
        self.dictInfo = [
            "lagTime": lagTime
        ]
    }
    
    required init?(dictionary: [AnyHashable : Any]) {
        if let lagTime = dictionary["lagTime"] as? Int {
            self.lagTime = lagTime
        }
    }
    
    func getDictInfo() -> [AnyHashable : Any] {
        return self.dictInfo
    }
}
