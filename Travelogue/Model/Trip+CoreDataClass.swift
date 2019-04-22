//
//  Trip+CoreDataClass.swift
//  Travelogue
//
//  Created by Brock Gibson on 4/19/19.
//  Copyright © 2019 Brock Gibson. All rights reserved.
//
//

import UIKit
import CoreData

@objc(Trip)
public class Trip: NSManagedObject {
    var entries: [Entry]? {
        return self.rawEntry?.array as? [Entry]
    }
    
    convenience init?(title: String, details: String) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        guard let context = appDelegate?.persistentContainer.viewContext else {
            return nil
        }
        
        self.init(entity: Trip.entity(), insertInto: context)
        
        self.title = title
        self.details = details
    }
}
