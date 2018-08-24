//
//  ProfileController.swift
//  Sirius
//
//  Created by Larissa Ganaha on 24/08/18.
//  Copyright © 2018 Giovani Nascimento Pereira. All rights reserved.
//

import UIKit

class ProfileController: UIViewController {

    @IBOutlet var editButtons: [UIButton]!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupButtons()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func setupButtons() {
        for element in editButtons {
            element.layer.cornerRadius = 10
        }
    }

}
