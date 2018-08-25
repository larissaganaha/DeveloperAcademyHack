//
//  NextAppointmentController.swift
//  Sirius
//
//  Created by Larissa Ganaha on 24/08/18.
//  Copyright © 2018 Giovani Nascimento Pereira. All rights reserved.
//

import UIKit
import Photos

class NextAppointmentController: UIViewController {
    @IBOutlet weak var pacientImage: UIImageView! {
        didSet {
            pacientImage.layer.cornerRadius = pacientImage.frame.size.width/2
        }
    }
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var symptomsTextField: UITextField!
    @IBOutlet weak var addPhotoButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var noImageLabel: UILabel!
    @IBOutlet weak var finishButton: UIButton!
    @IBOutlet weak var sinptomsLabel: UILabel!
    
    var images: [UIImage] = []

    var pacient: Pacient?
    
    var appointment: Appointment!

    override func viewDidLoad() {
        super.viewDidLoad()
        addPhotoButton.layer.cornerRadius = 17
        finishButton.layer.cornerRadius = 20
        symptomsTextField.delegate = self
        noImageLabel.isHidden = true
        
        if let textsLog = appointment.sinptomLog?.texts {
            self.sinptomsLabel.text = textsLog.reduce("", { (result, string) -> String in
                return result + ", \(string)"
            })
        } else {
            self.sinptomsLabel.text = ""
        }
        
        reloadLabels()
    }

    @IBAction func finishedPressed(_ sender: Any) {
        updateAppointment()
        performSegue(withIdentifier: "unwindToHomeScreen", sender: nil)
    }
    
    private func reloadLabels() {
        if let pacient = self.pacient, let app = self.appointment {
            self.nameLabel.text = pacient.name
            self.pacientImage.kf.setImage(with: pacient.realURL)
            self.idLabel.text = pacient.ID
            let hour = Calendar.current.component(.hour, from: app.scheduledTime)
            let minute = Calendar.current.component(.minute, from: app.scheduledTime)
            self.timeLabel.text = "Horário da consulta: \(hour)h\(minute)min"
        }
    }
    
    func updateAppointment() {
        var sinpLog: DataLog
        if let log = self.appointment.sinptomLog {
            sinpLog = log
        } else {
            sinpLog = DataLog(date: Date(), images: [], texts: [])
        }
        
        guard let info = sinptomsLabel.text?.components(separatedBy: ",") else { return }
        sinpLog.texts = info
        
        self.appointment.sinptomLog = sinpLog
//        AppointmentService().saveAppointment(appointment)
    }
}

extension NextAppointmentController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let text = textField.text {
            self.sinptomsLabel.text?.append(", ")
            self.sinptomsLabel.text?.append(text)
        }
        self.view.endEditing(true)
        return false
    }
}

extension NextAppointmentController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBAction func addPhotoPressed(_ sender: Any) {
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
            self.images.append(selectedImage)
            collectionView.reloadData()
        }
        dismiss(animated: true, completion: nil)
    }
}

extension NextAppointmentController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let numberOfItens = self.images.count
        if (numberOfItens == 0) {
            self.noImageLabel.isHidden = false
        } else {
            self.noImageLabel.isHidden = true
        }
        return self.images.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? GalleryColletionCell {
            cell.photoImage.image = self.images[indexPath.row]
            cell.photoImage.layer.cornerRadius = 10
            return cell
        }
        return GalleryColletionCell()
    }
}
