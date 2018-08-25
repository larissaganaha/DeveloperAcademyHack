//
//  DataLog.swift
//  Sirius
//
//  Created by Giovani Nascimento Pereira on 24/08/18.
//  Copyright © 2018 Giovani Nascimento Pereira. All rights reserved.
//

import UIKit

class DataLog: PersistenceObject {
    var date: Date
    var images: [String]
    var texts: [String]
    var dictInfo: [AnyHashable: Any] = [:]
    
    init (date: Date, images: [String], texts: [String]) {
        self.date = date
//        let imageUrls = images.map{URL(string: $0)!}
//        self.images = imageUrls
        self.images = images
        self.texts = texts
        
        self.dictInfo = [
            "date": date,
            "images": images,
            "texts": texts
        ]
    }
    
    required init?(dictionary: [AnyHashable : Any]) {
        if  let date = dictionary["date"] as? Date,
            let images = dictionary["images"] as? [String],
            let texts = dictionary["texts"] as? [String] {
            self.date = date
//            self.images = images.map{URL(string: $0)!}
            self.images = images
            self.texts = texts
            self.dictInfo = dictionary
        } else {
            print("Dictionary incomplete to create DataLog object")
            return nil
        }
    }
    
    func getDictInfo() -> [AnyHashable : Any] {
        return self.dictInfo
    }
}
