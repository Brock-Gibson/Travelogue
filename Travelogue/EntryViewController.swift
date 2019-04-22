//
//  EntryViewController.swift
//  Travelogue
//
//  Created by Brock Gibson on 4/19/19.
//  Copyright © 2019 Brock Gibson. All rights reserved.
//

import UIKit

class EntryViewController: UIViewController {

    @IBOutlet weak var entriesTableView: UITableView!
    
    var trip: Trip?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        entriesTableView.dataSource = self
        entriesTableView.delegate = self

        // Do any additional setup after loading the view.
    }
    @IBAction func addEntry(_ sender: Any) {
        performSegue(withIdentifier: "showEntry", sender: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.entriesTableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? NewEntryViewController else {
            return
        }
        
        //send trip no matter what
        destination.trip = trip
        
        //only send existing entry if there is actually a row selected
        if let selectedRow = self.entriesTableView.indexPathForSelectedRow?.row {
            destination.exisitingEntry = trip?.entries?[selectedRow]
        }
        
    }
    
    func deleteEntry(at indexPath: IndexPath) {
        guard let entry = trip?.entries?[indexPath.row],
            let managedContext = entry.managedObjectContext else {
                return
        }
        
        managedContext.delete(entry)
        
        do {
            try managedContext.save()
            
            entriesTableView.deleteRows(at: [indexPath], with: .automatic)
        }
        catch {
            print("expense could not be deleted")
            
            entriesTableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }

}

extension EntryViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trip?.entries?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = entriesTableView.dequeueReusableCell(withIdentifier: "entryCell", for: indexPath)
        
        guard let entry = trip?.entries?[indexPath.row] else {
            return cell
        }
        
        if let cell = cell as? EntryTableViewCell {
            cell.entryTitle.text = entry.title
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteEntry(at: indexPath)
        }
    }
}
