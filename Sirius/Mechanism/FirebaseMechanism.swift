//
//  FirebaseMechanism.swift
//  Sirius
//
//  Created by Bianca Itiroko on 24/08/18.
//  Copyright © 2018 Giovani Nascimento Pereira. All rights reserved.
//

import UIKit

protocol PersistenceObject {
    init?(dictionary: [AnyHashable: Any])
    func getDictInfo() -> [AnyHashable: Any]
}

class FirebaseMechanism: NSObject {
    
}
