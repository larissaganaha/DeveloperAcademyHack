//
//  InfoTableViewCell.swift
//  SiriusDoctor
//
//  Created by Giovani Nascimento Pereira on 24/08/18.
//  Copyright © 2018 Giovani Nascimento Pereira. All rights reserved.
//

import UIKit

class InfoTableViewCell: UITableViewCell {
    
    var backgrounds: [UIImage] = [#imageLiteral(resourceName: "purpleGradient"), #imageLiteral(resourceName: "blueGradient"), #imageLiteral(resourceName: "greenGradient")]
    var titles: [String] = ["Informações Pessoais", "Doenças na família", "Medicações"]
    
    var personalInfo: String = "personal info"
    var familyHistory: String = "family history"
    var medications: String = "medications"
    
    var bodies: [String] {
        var array: [String] = []
        array.append(personalInfo)
        array.append(familyHistory)
        array.append(medications)
        return array
    }

    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.dataSource = self
        }
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

extension InfoTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.backgrounds.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "infoCollectionViewCell", for: indexPath) as? InfoCollectionViewCell else { return UICollectionViewCell() }
        cell.image.image = self.backgrounds[indexPath.row]
        cell.titleLabel.text = self.titles[indexPath.row]
        cell.bodyLabel.text = self.bodies[indexPath.row]
        return cell
    }
}
