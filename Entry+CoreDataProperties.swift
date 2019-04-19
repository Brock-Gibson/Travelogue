//
//  Entry+CoreDataProperties.swift
//  Travelogue
//
//  Created by Brock Gibson on 4/19/19.
//  Copyright © 2019 Brock Gibson. All rights reserved.
//
//

import Foundation
import CoreData


extension Entry {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Entry> {
        return NSFetchRequest<Entry>(entityName: "Entry")
    }

    @NSManaged public var rawImage: NSData?
    @NSManaged public var rawDate: NSDate?
    @NSManaged public var title: String?
    @NSManaged public var content: String?
    @NSManaged public var trip: Trip?

}
