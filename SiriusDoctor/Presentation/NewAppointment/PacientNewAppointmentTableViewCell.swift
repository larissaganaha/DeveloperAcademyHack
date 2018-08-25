//
//  PacientNewAppointmentTableViewCell.swift
//  SiriusDoctor
//
//  Created by Giovani Nascimento Pereira on 25/08/18.
//  Copyright © 2018 Giovani Nascimento Pereira. All rights reserved.
//

import UIKit

class PacientNewAppointmentTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView! {
        didSet {
            profileImage.layer.cornerRadius = profileImage.frame.size.width/2
            profileImage.clipsToBounds = true
        }
    }
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var id: UILabel!
    
    func setup(_ pacient: Pacient) {
        self.profileImage.kf.setImage(with: pacient.realURL)
        self.name.text = pacient.name
        self.id.text = "MED ID: \(pacient.ID)"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
