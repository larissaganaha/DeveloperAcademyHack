//
//  ProfileController.swift
//  Sirius
//
//  Created by Larissa Ganaha on 24/08/18.
//  Copyright © 2018 Giovani Nascimento Pereira. All rights reserved.
//

import UIKit
import Photos

class ProfileController: UIViewController {

    @IBOutlet weak var pacientImage: UIImageView!
    @IBOutlet var editButtons: [UIButton]!

    var pacient:Pacient?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupButtons()

        self.pacientImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSelectProfileImage)))
        self.pacientImage.isUserInteractionEnabled = true
        
        PacientFirebaseMechanism.shared.retrievePacient(id: "164923") { (pacient) in
            if let pacient = pacient {
                self.pacient = pacient
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func setupButtons() {
        for element in editButtons {
            element.layer.cornerRadius = 15
        }
    }
    @IBAction func doneButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "unwindToHome", sender: nil)
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
//        let userID = Auth.auth().currentUser?.uid
        
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
