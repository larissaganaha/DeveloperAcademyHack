//
//  EndTableViewCell.swift
//  SiriusDoctor
//
//  Created by Giovani Nascimento Pereira on 24/08/18.
//  Copyright © 2018 Giovani Nascimento Pereira. All rights reserved.
//

import UIKit

class EndTableViewCell: UITableViewCell {

    @IBOutlet weak var endButton: UIButton!
    weak var delegate: EndCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func endButtonPressed(_ sender: Any) {
        delegate?.endButtonPressed()
    }
    
}

protocol EndCellDelegate: NSObjectProtocol {
    func endButtonPressed()
}
