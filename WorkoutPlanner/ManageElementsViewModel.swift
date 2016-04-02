//
//  ManageElementsViewModel.swift
//  WorkoutPlanner
//
//  Created by Michał Moskała on 11.02.2016.
//  Copyright © 2016 Michal Moskala. All rights reserved.
//

import Foundation

class ManageElementsViewModel {
    
    let workoutElementsModel = PredefinedWorkoutElementsModel()
    
    func elementsCount() -> Int {
        return workoutElementsModel.predefinedElements.count
    }
    
    func cellViewModel(row: Int) -> WorkoutElementCellViewModel {
        return WorkoutElementCellViewModel(workoutElement: workoutElementsModel.predefinedElements[row])
    }
    
}