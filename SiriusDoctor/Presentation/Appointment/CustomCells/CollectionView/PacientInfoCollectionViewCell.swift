//
//  PacientInfoCollectionViewCell.swift
//  SiriusDoctor
//
//  Created by Giovani Nascimento Pereira on 24/08/18.
//  Copyright © 2018 Giovani Nascimento Pereira. All rights reserved.
//

import UIKit

class PacientInfoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var backgroundImageView: UIImageView! {
        didSet {
            backgroundImageView.layer.cornerRadius = 10
            backgroundImageView.clipsToBounds = true
            backgroundImageView.layer.shadowColor = UIColor.black.cgColor
            backgroundImageView.layer.shadowOffset = CGSize(width: 2, height: 2)
            backgroundImageView.layer.shadowRadius = 5
            backgroundImageView.layer.shadowOpacity = 0.1
        }
    }
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
}
