//
//  DetailsTableCellPhotos.swift
//  Sirius
//
//  Created by Larissa Ganaha on 25/08/18.
//  Copyright © 2018 Giovani Nascimento Pereira. All rights reserved.
//

import UIKit

class DetailsTableCellPhotos: UITableViewCell {

    @IBOutlet weak var photoCollectionView: UICollectionView!

    override func awakeFromNib() {
        super.awakeFromNib()
        photoCollectionView.delegate = self
        photoCollectionView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension DetailsTableCellPhotos: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCollectionCell", for: indexPath) as? PhotosCollectionCell {
            cell.photoImage.image = UIImage(named: "test")
            return cell
        }
        return PhotosCollectionCell()
    }


}
