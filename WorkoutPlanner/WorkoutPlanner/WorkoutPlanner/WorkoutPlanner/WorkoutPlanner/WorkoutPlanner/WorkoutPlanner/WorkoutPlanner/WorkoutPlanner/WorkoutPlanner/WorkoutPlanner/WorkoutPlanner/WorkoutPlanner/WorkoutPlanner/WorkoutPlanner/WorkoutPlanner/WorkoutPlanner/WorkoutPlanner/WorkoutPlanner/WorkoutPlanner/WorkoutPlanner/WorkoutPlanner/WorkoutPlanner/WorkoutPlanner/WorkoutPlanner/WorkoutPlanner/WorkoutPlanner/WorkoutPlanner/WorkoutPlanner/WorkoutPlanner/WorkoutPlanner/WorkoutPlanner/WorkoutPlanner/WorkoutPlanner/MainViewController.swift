//
//  MainViewController.swift
//  WorkoutPlanner
//
//  Created by Michał Moskała on 30.01.2016.
//  Copyright © 2016 Michal Moskala. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var timeLineCollectionView: UICollectionView!
    @IBOutlet weak var workoutElementsCollectionView: UICollectionView!
    @IBOutlet weak var actualElementDescriptionLabel: UILabel!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var changeElementTimeButton: UIButton!
    
    var viewModel = MainViewModel()
    let cellReuseIdentifier = "cell"
    var selectedWorkoutElementIndexPath: NSIndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionViews()
    }
    
    private func setupCollectionViews() {
        let cellNib = UINib(nibName: "WorkoutElementCell", bundle: nil)
        timeLineCollectionView.registerNib(cellNib, forCellWithReuseIdentifier: cellReuseIdentifier)
        workoutElementsCollectionView.registerNib(cellNib, forCellWithReuseIdentifier: cellReuseIdentifier)
    }
    
    
    @IBAction func addButtonTapped(sender: UIButton) {
        
    }
    
    
    @IBAction func changeElementTimeTapped(sender: UIButton) {
        if let _ = selectedWorkoutElementIndexPath {
            performSegueWithIdentifier("PresentChangeTimeViewController", sender: self)
        }
    }
    
}

extension MainViewController: UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.workoutElementsCollectionView {
            return 0
        } else {
            return viewModel.timeLineElements.count
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellReuseIdentifier, forIndexPath: indexPath) as! WorkountElementCell
        if collectionView == self.workoutElementsCollectionView {
            let cellViewModel = viewModel.workoutElementCellViewModelForRow(indexPath.row)
            cell.configureWithViewModel(cellViewModel)
        } else {
            let cellViewModel = viewModel.timeLineCellViewModelForRow(indexPath.row)
            cell.configureWithViewModel(cellViewModel)
        }
        return cell
    }
}

extension MainViewController: UICollectionViewDelegate {
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if collectionView == self.workoutElementsCollectionView {
            selectedWorkoutElementIndexPath = indexPath
        }
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: 100, height: 50)
    }
}
