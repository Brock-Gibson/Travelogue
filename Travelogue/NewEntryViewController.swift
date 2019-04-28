//
//  NewEntryViewController.swift
//  Travelogue
//
//  Created by Brock Gibson on 4/19/19.
//  Copyright © 2019 Brock Gibson. All rights reserved.
//

import UIKit
import CoreData

class NewEntryViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var exisitingEntry: Entry?
    var trip: Trip?
    let imagePicker = UIImagePickerController()

    @IBOutlet weak var titleBar: UINavigationItem!
    @IBOutlet weak var entryImage: UIImageView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleBar.title = exisitingEntry?.title ?? "New Entry"
        titleTextField.text = exisitingEntry?.title
        descriptionTextView.text = exisitingEntry?.content
        entryImage.image = exisitingEntry?.image
        if let date = exisitingEntry?.date, let image = exisitingEntry?.image {
            datePicker.date = date
            entryImage.image = image
        }
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(NewEntryViewController.imageTapped(gestureRecognizer:)))
        entryImage.addGestureRecognizer(tapGesture)
        entryImage.isUserInteractionEnabled = true
        
        entryImage.layer.borderWidth = 1.0
        entryImage.layer.masksToBounds = false
        entryImage.layer.borderColor = UIColor.white.cgColor
        entryImage.layer.cornerRadius = self.entryImage.frame.width / 2
        entryImage.clipsToBounds = true
        
    }
    
    //Action
    @objc func imageTapped(gestureRecognizer: UITapGestureRecognizer) {
        let alert: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        let gallaryAction = UIAlertAction(title: "Open Gallary", style: .default) {
            UIAlertAction in self.openPhotoLibrary()
        }
        let cameraAction = UIAlertAction(title: "Open Camera", style: .default) {
            UIAlertAction in self.openCamera()
        }
        
        alert.addAction(cameraAction)
        alert.addAction(gallaryAction)
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func titleChanged(_ sender: Any) {
        titleBar.title = titleTextField.text
    }
    
    @IBAction func saveEntry(_ sender: Any) {
        let title = titleTextField.text ?? ""
        let description = descriptionTextView.text ?? ""
        let tripDate = datePicker.date
        let image = entryImage.image
        
        let entryTitle = title.trimmingCharacters(in: .whitespaces)
        if (entryTitle == "" || entryImage.image == nil) {
            alertNotifyUser(message: "Entry not saved. Fill out the required fields..")
            return
        }
        
        var entry: Entry?

        if let exisitingEntry = exisitingEntry {
            exisitingEntry.title = entryTitle
            exisitingEntry.content = description
            exisitingEntry.date = tripDate
            exisitingEntry.image = image
            
            entry = exisitingEntry
        } else {
            entry = Entry(title: entryTitle, content: description, date: tripDate, image: image)
            if let entry = entry {
                trip?.addToRawEntry(entry)
            }
        }
        
        if let entry = entry {
            
            do {
                let managedContext = entry.managedObjectContext
                
                try managedContext?.save()
                
                self.navigationController?.popViewController(animated: true)
            }
            catch {
                print("context could not be saved")
            }
        }
    }
    
    func alertNotifyUser(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func openCamera() {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            let alert = UIAlertController(title: "Camera", message: "Camera Not Available On Device", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        imagePicker.sourceType = .camera
        imagePicker.delegate = self
        present(imagePicker, animated: true)
    }
    
    func openPhotoLibrary() {
        guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else {
            let alert = UIAlertController(title: "Photo Library", message: "Photo Library Not Available On Device", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        present(imagePicker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        defer {
            picker.dismiss(animated: true)
        }
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            return
        }
        
        entryImage.image = image
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        defer {
            picker.dismiss(animated: true)
        }
    }

}
