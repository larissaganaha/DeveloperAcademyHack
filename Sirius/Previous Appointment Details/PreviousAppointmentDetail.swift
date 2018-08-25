//
//  PreviousAppointmentDetail.swift
//  Sirius
//
//  Created by Larissa Ganaha on 25/08/18.
//  Copyright © 2018 Giovani Nascimento Pereira. All rights reserved.
//

import UIKit

class PreviousAppointmentDetail: UIViewController {

    @IBOutlet weak var closeButton: UIButton!
    var sections = ["Fotos", "Exames realizados"]

    override func viewDidLoad() {
        super.viewDidLoad()
        closeButton.layer.cornerRadius = 18

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func closeButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "unwindtoHomeScreen", sender: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
extension PreviousAppointmentDetail: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "tableCellPhotos", for: indexPath) as? DetailsTableCellPhotos {
            return cell
        }
        return DetailsTableCellPhotos()

    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        let titleLabel = UILabel()
        titleLabel.textAlignment = .left
        titleLabel.font = UIFont(name: "Poppins-SemiBold", size: 16)
        titleLabel.text = "Fotos"
        titleLabel.frame = CGRect(x: 30, y: 10, width: view.bounds.width, height: 30)
        titleLabel.textColor = .black
        headerView.addSubview(titleLabel)
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35
    }


}
