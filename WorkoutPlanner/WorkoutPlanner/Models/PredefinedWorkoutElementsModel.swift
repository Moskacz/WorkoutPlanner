//
//  WorkoutElementsModel.swift
//  WorkoutPlanner
//
//  Created by Michał Moskała on 08.02.2016.
//  Copyright © 2016 Michal Moskala. All rights reserved.
//

import Foundation
import CoreData
import Bond

class PredefinedWorkoutElementsModel: NSObject {
    
    let coreDataStack = CoreDataStack.sharedInstance
    var predefinedElementsFRC: NSFetchedResultsController!
    var predefinedElements = [WorkoutElement]()
    let reloadElements = Observable<Bool>(false)
    
    override init() {
        super.init()
        self.createPredefinedElementsIfNeeded()
        self.setupPredefinedElementsFetchedResultsController()
        self.fetchPredefinedElements()
    }
    
    // MARK: private methods
    
    private func createPredefinedElementsIfNeeded() {
        guard numberOfPredefinedElements() == 0 else { return }
        
        let entity = NSEntityDescription.entityForName("WorkoutElement", inManagedObjectContext: coreDataStack.managedObjectContext)!
        
        let restElement = WorkoutElement(entity: entity, insertIntoManagedObjectContext: coreDataStack.managedObjectContext)
        restElement.name = "Rest"
        restElement.duration = NSNumber(double: 10.0)
        restElement.isPredefined = NSNumber(bool: true)
        restElement.color = UIColor.lightGrayColor()
        restElement.soundName = "odpoczywaj"
        
        let activeElement = WorkoutElement(entity: entity, insertIntoManagedObjectContext: coreDataStack.managedObjectContext)
        activeElement.name = "Workout"
        activeElement.duration = NSNumber(double: 30.0)
        activeElement.isPredefined = NSNumber(bool: true)
        activeElement.color = UIColor.orangeColor()
        activeElement.soundName = "cwicz"
        
        coreDataStack.saveContext()
    }
    
    private func numberOfPredefinedElements() -> Int {
        let fetchRequest = predefinedElementsFetchRequest()
        var error: NSError? = nil
        return coreDataStack.managedObjectContext.countForFetchRequest(fetchRequest, error: &error)
    }
    
    private func predefinedElementsFetchRequest() -> NSFetchRequest {
        let fetchRequest = NSFetchRequest(entityName: "WorkoutElement")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: false)]
        fetchRequest.predicate = NSPredicate(format: "isPredefined == true")
        return fetchRequest
    }
    
    private func setupPredefinedElementsFetchedResultsController() {
        let fetchRequest = predefinedElementsFetchRequest()
        self.predefinedElementsFRC = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: coreDataStack.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        self.predefinedElementsFRC.delegate = self
    }
    
    private func fetchPredefinedElements() {
        do {
            try predefinedElementsFRC.performFetch()
            if let objects = predefinedElementsFRC.fetchedObjects as? [WorkoutElement] {
                predefinedElements = objects
            }
        } catch let error as NSError {
            print("Error: \(error)")
        }
    }
    
    // MARK: public methods
    
    func createNewElement() -> WorkoutElement {
        let entity = NSEntityDescription.entityForName("WorkoutElement", inManagedObjectContext: coreDataStack.managedObjectContext)!
        return WorkoutElement(entity: entity, insertIntoManagedObjectContext: coreDataStack.managedObjectContext)
    }
    
    func createTimeLineElementBasedOnElement(element: WorkoutElement) -> WorkoutElement {
        let entity = NSEntityDescription.entityForName("WorkoutElement", inManagedObjectContext: coreDataStack.additionalObjectContext)!
        let newElement = WorkoutElement(entity: entity, insertIntoManagedObjectContext: coreDataStack.additionalObjectContext)
        newElement.name = element.name
        newElement.soundName = element.soundName
        newElement.isPredefined = NSNumber(bool: false)
        newElement.duration = element.duration
        newElement.color = element.color
        return newElement
    }
    
    func saveChanges() {
        coreDataStack.saveContext()
    }
}

extension PredefinedWorkoutElementsModel: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        if let elements = controller.fetchedObjects as? [WorkoutElement] {
            predefinedElements = elements
            reloadElements.next(true)
        }
    }
}