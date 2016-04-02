//
//  AddElementViewModel.swift
//  WorkoutPlanner
//
//  Created by Michał Moskała on 12.02.2016.
//  Copyright © 2016 Michal Moskala. All rights reserved.
//

import UIKit
import Bond

class AddElementViewModel{
    
    let workoutElementsModel = PredefinedWorkoutElementsModel()
    let name = Observable<String?>(nil)
    let minutes = Observable<String?>(nil)
    let seconds = Observable<String?>(nil)
    let color = Observable<UIColor?>(nil)
    let soundName = Observable<String?>(nil)
    let duration = Observable<Double>(0.0)
    let formValid = Observable<Bool>(false)
    
    
    init() {
        setupObservers()
    }
    
    private func setupObservers() {
        let validNameEvent = name.map { $0?.characters.count > 0 }
        let minutesIntEvent = minutes.map{ $0 ?? "" }.map{ Int($0) ?? 0 }.map{ $0 * 60 }
        let secondsIntEvent = seconds.map { $0 ?? "" }.map{ Int($0) ?? 0 }
        combineLatest(minutesIntEvent, secondsIntEvent).map { Double($0 + $1) }.bindTo(duration)
        let validColorEvent = color.map{ $0 != nil }
        let validDurationEvent = duration.map { $0 > 0 }
        let validSoundNameEvent = soundName.map { $0?.characters.count > 0 }
        combineLatest(validNameEvent, validDurationEvent, validColorEvent, validSoundNameEvent).map {
            $0 && $1 && $2 && $3
        }.bindTo(formValid)
    }
    
    func createNewWorkoutElement() {
        let newElement = workoutElementsModel.createNewElement()
        newElement.name = name.value
        newElement.duration = NSNumber(double: duration.value)
        newElement.isPredefined = NSNumber(bool: true)
        newElement.color = color.value
        newElement.soundName = soundName.value
        workoutElementsModel.saveChanges()
    }
}