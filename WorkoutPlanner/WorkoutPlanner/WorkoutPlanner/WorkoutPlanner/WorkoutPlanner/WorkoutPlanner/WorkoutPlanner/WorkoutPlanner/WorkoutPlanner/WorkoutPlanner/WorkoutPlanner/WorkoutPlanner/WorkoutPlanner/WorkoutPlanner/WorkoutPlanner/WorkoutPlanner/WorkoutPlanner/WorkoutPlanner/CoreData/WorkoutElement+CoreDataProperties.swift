//
//  WorkoutElement+CoreDataProperties.swift
//  WorkoutPlanner
//
//  Created by Michał Moskała on 08.02.2016.
//  Copyright © 2016 Michal Moskala. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension WorkoutElement {

    @NSManaged var name: String?
    @NSManaged var duration: NSNumber?
    @NSManaged var isPredefined: NSNumber?
    @NSManaged var color: String?

}
