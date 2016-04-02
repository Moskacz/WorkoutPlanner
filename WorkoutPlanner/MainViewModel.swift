//
//  MainViewModel.swift
//  WorkoutPlanner
//
//  Created by Michał Moskała on 30.01.2016.
//  Copyright © 2016 Michal Moskala. All rights reserved.
//

import Foundation
import Bond

class MainViewModel {
    
    var timeLineElements = [WorkoutElement]()
    let predefinedElementsModel = PredefinedWorkoutElementsModel()
    let updateWorkoutDescription = Observable<Bool>(false)
    let indexPathForCellToInsert = Observable<NSIndexPath?>(nil)
    let indexPathsForCellDeletion = Observable<[NSIndexPath]?>(nil)
    
    func predefinedElementsCount() -> Int {
        return predefinedElementsModel.predefinedElements.count
    }
    
    func workoutElementCellViewModelForRow(row: Int) -> WorkoutElementCellViewModel {
        let element = predefinedElementsModel.predefinedElements[row]
        return WorkoutElementCellViewModel(workoutElement: element)
    }
    
    func timeLineCellViewModelForRow(row: Int) -> WorkoutElementCellViewModel {
        let element = timeLineElements[row]
        return WorkoutElementCellViewModel(workoutElement: element)
    }
    
    func insertElementAtRowToTimelineElements(row: Int) {
        let element = predefinedElementsModel.predefinedElements[row]
        let newElement = predefinedElementsModel.createTimeLineElementBasedOnElement(element)
        timeLineElements.append(newElement)
        updateWorkoutDescription.next(true)
        let indexPath = NSIndexPath(forRow:timeLineElements.count - 1, inSection: 0)
        indexPathForCellToInsert.next(indexPath)
    }
    
    func clearTimeLine() {
        var indexPaths = [NSIndexPath]()
        
        for index in 0..<timeLineElements.count {
            indexPaths.append(NSIndexPath(forRow: index, inSection: 0))
        }
        
        timeLineElements.removeAll()
        indexPathsForCellDeletion.next(indexPaths)
        predefinedElementsModel.coreDataStack.additionalObjectContext.reset()
        updateWorkoutDescription.next(true)
    }
    
    var timeLineWorkoutDuration: Double {
        return timeLineElements.reduce(0, combine: {
            return $0 + ($1.duration?.doubleValue ?? 0.0)
        })
    }
    
    func workoutDurationText() -> String {
        let duration = timeLineWorkoutDuration
        let durationInMinString = String(format: "%0.2f [min]", duration / 60.0)
        return "Workout duration: \(timeLineWorkoutDuration)[sec] (\(durationInMinString))"
    }
}