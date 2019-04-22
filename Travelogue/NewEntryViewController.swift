//
//  NewEntryViewController.swift
//  Travelogue
//
//  Created by Brock Gibson on 4/19/19.
//  Copyright © 2019 Brock Gibson. All rights reserved.
//

import UIKit
import CoreData

class NewEntryViewController: UIViewController {
    
    var exisitingEntry: Entry?
    var trip: Trip?

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
        if let date = exisitingEntry?.date {
            datePicker.date = date
        }
        // Do any additional setup after loading the view.
    }
    @IBAction func titleChanged(_ sender: Any) {
        titleBar.title = titleTextField.text
    }
    
    @IBAction func saveEntry(_ sender: Any) {
        let title = titleTextField.text ?? ""
        let description = descriptionTextView.text ?? ""
        let tripDate = datePicker.date
        
        let entryTitle = title.trimmingCharacters(in: .whitespaces)
        if (entryTitle == "") {
            alertNotifyUser(message: "Entry not saved. A name is required.")
            return
        }
        
        var entry: Entry?
        
        if let exisitingEntry = exisitingEntry {
            exisitingEntry.title = entryTitle
            exisitingEntry.content = description
            exisitingEntry.date = tripDate
            
            entry = exisitingEntry
        } else {
            entry = Entry(title: entryTitle, content: description, date: tripDate, image: UIImage())
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

}
