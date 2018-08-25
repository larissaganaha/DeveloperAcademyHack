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
    @IBOutlet weak var noImageLabel1: UILabel!
    @IBOutlet weak var noImageLabel2: UILabel!
    @IBOutlet weak var finishButton: UIButton!
    @IBOutlet weak var sinptomsLabel: UILabel!
    
    @IBOutlet weak var collectionViewPhotos: UICollectionView!
    @IBOutlet weak var collectionViewExams: UICollectionView!
    
    var photos: [UIImage] = []
    var exams: [UIImage] = []

    var pacient: Pacient?
    var appointment: Appointment!
    
    var wasPhotosPressed: Bool = true
    
    var arrayURLs: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        addPhotoButton.layer.cornerRadius = 17
        finishButton.layer.cornerRadius = 20
        symptomsTextField.delegate = self
        noImageLabel1.isHidden = true
        noImageLabel2.isHidden = true
        
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
        
        sinpLog.images = self.arrayURLs
        
        self.appointment.sinptomLog = sinpLog
        
        self.appointment.dictInfo["imagesSinp"] = self.arrayURLs
        self.appointment.dictInfo["textsSinp"] = info
        self.appointment.dictInfo["dateSinp"] = Date().toString(dateFormat: "dd-MM-yyyy hh:mm")
        
        AppointmentService().saveAppointment(appointment)
    }
}

extension NextAppointmentController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let text = textField.text {
            if text == "" { return false }
            self.sinptomsLabel.text?.append(text)
            self.sinptomsLabel.text?.append(", ")
        }
        self.view.endEditing(true)
        textField.text = ""
        return false
    }
}

extension NextAppointmentController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBAction func addPhotoPressed(_ sender: Any) {
        self.wasPhotosPressed = true
        openLibrary()
    }
    
    @IBAction func addExamPressed(_ sender: Any) {
        self.wasPhotosPressed = false
        openLibrary()
    }
    
    private func openLibrary() {
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
            if self.wasPhotosPressed {
                self.photos.append(selectedImage)
                collectionViewPhotos.reloadData()
            } else {
                self.exams.append(selectedImage)
                collectionViewExams.reloadData()
            }
            
            PacientFirebaseMechanism.shared.uploadImage(profileImage: selectedImage, pacientID: self.pacient?.ID ?? "") { (url) in
                self.arrayURLs.append(url!) }
        }
        
        
            
        dismiss(animated: true, completion: nil)
    }
}

extension NextAppointmentController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectionViewPhotos {
            let numberOfItens = self.photos.count
            if (numberOfItens == 0) {
                self.noImageLabel1.isHidden = false
            } else {
                self.noImageLabel1.isHidden = true
            }
            return self.photos.count
        } else {
            let numberOfItens = self.exams.count
            if (numberOfItens == 0) {
                self.noImageLabel2.isHidden = false
            } else {
                self.noImageLabel2.isHidden = true
            }
            return self.exams.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.collectionViewPhotos {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? GalleryColletionCell {
                cell.photoImage.image = self.photos[indexPath.row]
                cell.photoImage.layer.cornerRadius = 10
                return cell
            }
            return GalleryColletionCell()
        } else {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? GalleryColletionCell {
                cell.photoImage.image = self.exams[indexPath.row]
                cell.photoImage.layer.cornerRadius = 10
                return cell
            }
        }
        
        return UICollectionViewCell()
    }
}
