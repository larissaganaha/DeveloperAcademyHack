//
//  ProfileTableViewCell.swift
//  SiriusDoctor
//
//  Created by Giovani Nascimento Pereira on 24/08/18.
//  Copyright © 2018 Giovani Nascimento Pereira. All rights reserved.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var telephone: UILabel!
    @IBOutlet weak var age: UILabel!
    @IBOutlet weak var picture: UIImageView! {
        didSet {
            picture.layer.cornerRadius = picture.frame.size.width/2
            picture.clipsToBounds = true
        }
    }
    
    weak var delegate: BackCellDelegate?
    @IBAction func backButtonPressed(_ sender: Any) {
        delegate?.backButtonPressed()
    }
}

protocol BackCellDelegate: NSObjectProtocol {
    func backButtonPressed()
}
