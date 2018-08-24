//
//  PacientTableViewCell.swift
//  SiriusDoctor
//
//  Created by Giovani Nascimento Pereira on 24/08/18.
//  Copyright © 2018 Giovani Nascimento Pereira. All rights reserved.
//

import UIKit

class PacientTableViewCell: UITableViewCell {
    
    private var cellColor: [UIImage] = [#imageLiteral(resourceName: "purpleGradient"), #imageLiteral(resourceName: "blueGradient"), #imageLiteral(resourceName: "greenGradient")]

    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}

extension PacientTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        print("loading")
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pacientInfoCollectionViwCell", for: indexPath) as? PacientInfoCollectionViewCell else { return UICollectionViewCell ()}
        cell.backgroundImageView.image = cellColor[indexPath.row]
        return cell
    }
}
