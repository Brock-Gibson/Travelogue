//
//  NewEntryViewController.swift
//  Travelogue
//
//  Created by Brock Gibson on 4/19/19.
//  Copyright © 2019 Brock Gibson. All rights reserved.
//

import UIKit

class NewEntryViewController: UIViewController {

    @IBOutlet weak var entryImage: UIImageView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveEntry(_ sender: Any) {
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
