//
//  HomeScreenController.swift
//  Sirius
//
//  Created by Larissa Ganaha on 24/08/18.
//  Copyright © 2018 Giovani Nascimento Pereira. All rights reserved.
//

import UIKit

class HomeScreenController: UIViewController {

    var categories = ["Consultas futuras", "Consultas passadas"]

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    @IBAction func unwindToHomeScreen(segue:UIStoryboardSegue) { }

}
extension HomeScreenController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath) as? HomeScreenTableCell {
            return cell
        }
        return HomeScreenTableCell()
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return categories.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }


    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        let titleLabel = UILabel()
        titleLabel.textAlignment = .left
        titleLabel.font = UIFont(name: "Poppins-SemiBold", size: 19)
        titleLabel.text = self.categories[section]
        titleLabel.frame = CGRect(x: 20, y: 10, width: view.bounds.width, height: 30)
        titleLabel.textColor = .white
        headerView.addSubview(titleLabel)
        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35
    }


}
