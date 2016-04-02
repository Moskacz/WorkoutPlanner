//
//  WorkoutElementCellViewModel.swift
//  WorkoutPlanner
//
//  Created by Michał Moskała on 30.01.2016.
//  Copyright © 2016 Michal Moskala. All rights reserved.
//

import UIKit

struct WorkoutElementCellViewModel {
    
    let workoutElement: WorkoutElement
    
    func getText() -> String {
        if let name = workoutElement.name, duration = workoutElement.duration {
            return "\(name)\n\(duration)sec"
        }
        return ""
    }
    
    func getBackgroundColor() -> UIColor {
        if let color = workoutElement.color as? UIColor {
            return color
        }
        
        return UIColor.blueColor()
    }
}