//
//  NewTripViewController.swift
//  Travelogue
//
//  Created by Brock Gibson on 4/19/19.
//  Copyright © 2019 Brock Gibson. All rights reserved.
//

import UIKit

class NewTripViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var detailsTextView: UITextView!
    
    var exisitingTrip: Trip?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleTextField.text = exisitingTrip?.title
        detailsTextView.text = exisitingTrip?.details
    }
    
    @IBAction func saveTrip(_ sender: Any) {
        let tripName = titleTextField.text ?? "".trimmingCharacters(in: .whitespaces)
        let tripDetails = detailsTextView.text ?? "".trimmingCharacters(in: .whitespaces)
        if (tripName == "") {
            alertNotifyUser(message: "Trip not saved. A name is required.")
            return
        }
        
        var trip: Trip?
        
        if let exisitingTrip = exisitingTrip {
            exisitingTrip.title = tripName
            exisitingTrip.details = tripDetails
            trip = exisitingTrip
        } else {
            trip = Trip(title: tripName, details: tripDetails)
        }
        
        if let trip = trip {
            do {
                try trip.managedObjectContext?.save()
                self.navigationController?.popViewController(animated: true)
            }
            catch {
                print("Could not save category!")
            }
        }
    }
    
    func alertNotifyUser(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
}
