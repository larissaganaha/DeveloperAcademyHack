//
//  DataLog.swift
//  Sirius
//
//  Created by Giovani Nascimento Pereira on 24/08/18.
//  Copyright © 2018 Giovani Nascimento Pereira. All rights reserved.
//

import UIKit

class DataLog {
    var date: Date
    var images: [UIImage]
    var texts: [String]
    
    init (date: Date, images: [UIImage], texts: [String]) {
        self.date = date
        self.images = images
        self.texts = texts
    }
}
