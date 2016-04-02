//
//  WorkoutElement+CoreDataProperties.swift
//  
//
//  Created by Michał Moskała on 13.02.2016.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension WorkoutElement {

    @NSManaged var duration: NSNumber?
    @NSManaged var isPredefined: NSNumber?
    @NSManaged var name: String?
    @NSManaged var color: NSObject?
    @NSManaged var soundName: String?

}
