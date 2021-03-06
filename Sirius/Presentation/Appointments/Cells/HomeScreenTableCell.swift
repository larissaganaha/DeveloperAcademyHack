//
//  HomeScreenTableCell.swift
//  Sirius
//
//  Created by Larissa Ganaha on 24/08/18.
//  Copyright © 2018 Giovani Nascimento Pereira. All rights reserved.
//

import UIKit

protocol HomeScreenTableViewCellDelegate: NSObjectProtocol {
    func getTableViewSectionIndex() -> Int
}

class HomeScreenTableCell: UITableViewCell {

    weak var delegate: HomeScreenTableViewCellDelegate?

    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self
        }
    }
    
    var appoints: [Appointment] = [] {
        didSet { self.collectionView.reloadData() }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func unwindToWaitHomeScreen(segue:UIStoryboardSegue) { }

}

extension HomeScreenTableCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.appoints.count
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("SELECTED: \(indexPath)")
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as? AppointmentCollectionCell {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyy"
            let timeFormatter = DateFormatter()
            timeFormatter.dateFormat = "hh:mm"
            cell.date.text = dateFormatter.string(from: appoints[indexPath.row].scheduledTime)
            cell.time.text = timeFormatter.string(from: appoints[indexPath.row].scheduledTime)
            return cell
        }
        return AppointmentCollectionCell()
    }



}
