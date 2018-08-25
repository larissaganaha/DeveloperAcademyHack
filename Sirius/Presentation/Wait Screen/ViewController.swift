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
    @IBOutlet weak var lagTime: UILabel!
    
    
    override func viewDidLoad() {
        goBackButton.layer.cornerRadius = 12
        super.viewDidLoad()
        
        LagTimeService.getLagTime(completion: { (lagtime) in
            if lagtime != nil {
                let hours = lagtime!/60
                if  hours > 0 {
                    self.lagTime.text = "+\(hours)h\(lagtime!%60)min"
                } else {
                    self.lagTime.text = "\(lagtime!) min"
                }
            }
        })
        
        LagTimeMechanismFirebase.shared.addObserverEventAdded { (lagTime) in
            self.lagTime.text = String(lagTime!)
        }
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

