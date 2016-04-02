//
//  MainViewModel.swift
//  WorkoutPlanner
//
//  Created by Michał Moskała on 30.01.2016.
//  Copyright © 2016 Michal Moskala. All rights reserved.
//

import Foundation

struct MainViewModel {
    var timeLineElements = [WorkoutElement]()
    
    func workoutElementCellViewModelForRow(row: Int) -> WorkoutElementCellViewModel {
        return WorkoutElementCellViewModel()
    }
    
    func timeLineCellViewModelForRow(row: Int) -> WorkoutElementCellViewModel {
        return WorkoutElementCellViewModel()
    }
    
}