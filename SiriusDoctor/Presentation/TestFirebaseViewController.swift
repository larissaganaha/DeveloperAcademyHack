//
//  TestFirebaseViewController.swift
//  SiriusDoctor
//
//  Created by Julianny Favinha on 8/24/18.
//  Copyright © 2018 Giovani Nascimento Pereira. All rights reserved.
//

import UIKit

class TestFirebaseViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    var pacientService: PacientService! = PacientService()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pacientService.getPacient(id: "1") { (pacient) in
            if let actualPacient = pacient {
                DispatchQueue.main.async {
                    self.label.text = actualPacient.name
                }
            }
        }
        
        let pac = Pacient(ID: "2", name: "Bia", address: "a", telephone: "13", bornDate: Date(), height: 1.0, weight: 1.0, drink: false, hipertension: false, diabetes: false, smoking: false)
        pacientService.savePacient(pac)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
