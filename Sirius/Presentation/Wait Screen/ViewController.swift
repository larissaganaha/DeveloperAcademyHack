//
//  ViewController.swift
//  Sirius
//
//  Created by Giovani Nascimento Pereira on 24/08/18.
//  Copyright © 2018 Giovani Nascimento Pereira. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var goBackButton: UIButton!

    override func viewDidLoad() {
        goBackButton.layer.cornerRadius = 12
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func goBackPressed(_ sender: Any) {
        performSegue(withIdentifier: "unwindToHomeScreen", sender: nil)
    }
    
    @IBAction func unwindToWaitScreen(segue:UIStoryboardSegue) { }

}

