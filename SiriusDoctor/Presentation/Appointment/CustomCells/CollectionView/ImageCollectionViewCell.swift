//
//  ImageCollectionViewCell.swift
//  SiriusDoctor
//
//  Created by Giovani Nascimento Pereira on 24/08/18.
//  Copyright © 2018 Giovani Nascimento Pereira. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var image: UIImageView! {
        didSet {
            image.layer.cornerRadius = 10
            image.clipsToBounds = true
        }
    }
}
