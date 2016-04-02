//
//  WorkoutViewModel.swift
//  WorkoutPlanner
//
//  Created by Michał Moskała on 13.02.2016.
//  Copyright © 2016 Michal Moskala. All rights reserved.
//

import Foundation
import Bond
import AVFoundation

class WorkoutViewModel {
    
    let elements: [WorkoutElement]
    var usedElements = [WorkoutElement]()
    let progressText = Observable<String>("")
    let timeLeftText = Observable<String>("")
    let titleLabelsHidden = Observable<Bool>(true)
    let countDownText = Observable<String>("")
    let pusheenAnimating = Observable<Bool>(false)
    
    var audioPlayer: AVAudioPlayer?
    var timer: NSTimer?
    var countDownValue = 4
    var workoutDuration: Double!
    var secondPassed = 0.0
    
    init(elements: [WorkoutElement]) {
        self.elements = elements
    }
    
    func start() {
        timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("countDown"), userInfo: nil, repeats: true)
    }
    
    private dynamic func countDown() {
        countDownValue -= 1
        if countDownValue == 0 {
            timer?.invalidate()
            startWorkout()
            titleLabelsHidden.next(false)
            countDownText.next("")
            pusheenAnimating.next(true)
        } else {
            countDownText.next("\(countDownValue)!")
        }
    }
    
    private func startWorkout() {
        workoutDuration = elements.reduce(0, combine: { $0 + ($1.duration?.doubleValue ?? 0.0)})
        timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("tick"), userInfo: nil, repeats: true)
    }
    
    private dynamic func tick() {
        secondPassed += 1.0
        if secondPassed >= workoutDuration {
            playSoundWithName("koniec_treningu")
            pusheenAnimating.next(false)
            invalidateTimer()
        }
        
        playElementSoundIfNeeded()
        computeNewTexts()
    }
    
    func invalidateTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    private func computeNewTexts() {
        let progress = (secondPassed / workoutDuration) * 100
        progressText.next(String(format: "%0.2f", progress) + "%")
        
        let overalSecondsLeft = workoutDuration - secondPassed
        let minutesLeft = Int(overalSecondsLeft / 60.0)
        let secondsLeft = Int(overalSecondsLeft) - minutesLeft * 60
        timeLeftText.next("\(minutesLeft)min \(secondsLeft)sec")
    }
    
    private func playElementSoundIfNeeded() {
        let usedElementsDuration = usedElements.reduce(0.0, combine: { $0 + $1.duration!.doubleValue })
        if secondPassed > usedElementsDuration {
            let notPlayedElements = elements.filter {
                self.usedElements.contains($0) == false
            }
            
            if let firstNotPlayedElement = notPlayedElements.first {
                if let soundName = firstNotPlayedElement.soundName {
                    playSoundWithName(soundName)
                    usedElements.append(firstNotPlayedElement)
                }
            }
        }
    }
    
    private func playSoundWithName(name: String) {
        guard let path = NSBundle.mainBundle().pathForResource(name, ofType: "mp3") else {
            return
        }
        
        let url = NSURL(fileURLWithPath: path)
        do {
            audioPlayer = try AVAudioPlayer(contentsOfURL: url)
            audioPlayer?.numberOfLoops = 1
            audioPlayer?.play()
        } catch let error as NSError {
            print(error)
        }
    }
}











