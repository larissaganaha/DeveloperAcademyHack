//
//  ProfileController.swift
//  Sirius
//
//  Created by Larissa Ganaha on 24/08/18.
//  Copyright © 2018 Giovani Nascimento Pereira. All rights reserved.
//

import UIKit
import Photos
import Kingfisher

class ProfileController: UIViewController {

    @IBOutlet weak var pacientImage: UIImageView! {
        didSet {
            pacientImage.layer.cornerRadius = pacientImage.frame.size.width/2
        }
    }
    
    @IBOutlet var editButtons: [UIButton]!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var bornDateLabel: UILabel!
    @IBOutlet weak var telephoneLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!

    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    
    @IBOutlet weak var familyDisease1Label: UILabel!
    @IBOutlet weak var familyDisease2Label: UILabel!
    
    @IBOutlet weak var checkBoxDrink: UIImageView!
    @IBOutlet weak var checkBoxSmoking: UIImageView!
    
    var pacient: Pacient?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupButtons()

        self.pacientImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSelectProfileImage)))
        self.pacientImage.isUserInteractionEnabled = true
        
        PacientFirebaseMechanism.shared.retrievePacient(id: "164923") { (pacient) in
            if let pacient = pacient {
                self.pacient = pacient
                self.reloadLabels()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    func setupButtons() {
        for element in editButtons {
            element.layer.cornerRadius = 4
        }
    }
    
    @IBAction func doneButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "unwindToHome", sender: nil)
    }
    
    private func reloadLabels() {
        if let pacient = self.pacient {
            self.pacientImage.kf.setImage(with: pacient.realURL)
            self.nameLabel.text = pacient.name
            self.idLabel.text = pacient.ID
            self.bornDateLabel.text = "\(pacient.bornDate.toString(dateFormat: "dd/MM/yyyy"))"
            self.telephoneLabel.text = "\(pacient.telephone)"
            self.addressLabel.text = "\(pacient.address)"
            self.weightLabel.text = "Peso: \(pacient.weight) kg"
            self.heightLabel.text = "Altura: \(pacient.height) m"
            
            var familyDiseases: [String] = [pacient.diabetes ? "Diabetes" : "",
                                          pacient.hipertension ? "Hipertensão" : ""]
            self.familyDisease1Label.text = familyDiseases[0]
            self.familyDisease2Label.text = familyDiseases[1]
            
            self.checkBoxDrink.image = pacient.drink ? #imageLiteral(resourceName: "checked box") :  #imageLiteral(resourceName: "unchecked box")
            self.checkBoxSmoking.image = pacient.smoking ? #imageLiteral(resourceName: "checked box") : #imageLiteral(resourceName: "unchecked box")
        }
    }
}

//Pick user image handlers
extension ProfileController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @objc func handleSelectProfileImage() {
        let photos = PHPhotoLibrary.authorizationStatus()
        if photos == .notDetermined || photos == .authorized {
            PHPhotoLibrary.requestAuthorization({ status in
                if status == .authorized {
                    let picker = UIImagePickerController()
                    picker.delegate = self
                    picker.allowsEditing = true
                    
                    self.present(picker, animated: true, completion: nil)
                } else {
                    self.alert(message: "No permission to access photo library") {_ in }
                }
            })
        }
    }
    
    func alert(message: String, completionHandler: @escaping (UIAlertAction) -> Void) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: completionHandler))
        self.present(alert, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: Any]) {
        var selectedImageFromPicker: UIImage?
        
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            selectedImageFromPicker = editedImage
        } else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            selectedImageFromPicker = originalImage
        }
        
        if let selectedImage = selectedImageFromPicker {
            self.pacientImage.image = selectedImage
            PacientFirebaseMechanism.shared.uploadImage(profileImage: selectedImage, pacientID: self.pacient?.ID ?? "") { (url) in
                if let pacient = self.pacient {
                    pacient.imageURL = url
                    PacientFirebaseMechanism.shared.createPacient(pacient: pacient)
                } else {
                    print("Pacient é nil!")
                }
            }
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
