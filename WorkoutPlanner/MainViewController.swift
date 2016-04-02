//
//  MainViewController.swift
//  WorkoutPlanner
//
//  Created by Michał Moskała on 30.01.2016.
//  Copyright © 2016 Michal Moskala. All rights reserved.
//

import UIKit
import Bond

class MainViewController: UIViewController {
    @IBOutlet weak var timeLineCollectionView: UICollectionView!
    @IBOutlet weak var workoutElementsCollectionView: UICollectionView!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var workoutDurationDescriptionLabel: UILabel!
    
    weak var containerViewController: ContainerViewController?
    
    var viewModel = MainViewModel()
    let cellReuseIdentifier = "cell"
    var selectedWorkoutElementIndexPath: NSIndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionViews()
        setupObservers()
    }
    
    private func setupCollectionViews() {
        let cellNib = UINib(nibName: "WorkoutElementCell", bundle: nil)
        timeLineCollectionView.registerNib(cellNib, forCellWithReuseIdentifier: cellReuseIdentifier)
        workoutElementsCollectionView.registerNib(cellNib, forCellWithReuseIdentifier: cellReuseIdentifier)
    }
    
    private func setupObservers() {
        viewModel.predefinedElementsModel.reloadElements.observe { _ in
            self.workoutElementsCollectionView.reloadData()
        }
        
        viewModel.updateWorkoutDescription.observe { _ in
            self.workoutDurationDescriptionLabel.text = self.viewModel.workoutDurationText()
        }
        
        viewModel.indexPathForCellToInsert.observe { indexPath in
            if let path = indexPath {
                self.timeLineCollectionView.insertItemsAtIndexPaths([path])
            }
        }
        
        viewModel.indexPathsForCellDeletion.observe { indexPaths in
            if let paths = indexPaths {
                self.timeLineCollectionView.deleteItemsAtIndexPaths(paths)
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let destinationVC = segue.destinationViewController as? WorkoutViewController {
            destinationVC.viewModel = WorkoutViewModel(elements: viewModel.timeLineElements)
        }
    }
    
    @IBAction func menuButtonTapped(sender: UIBarButtonItem) {
        containerViewController?.toggleSideView()
    }
    
    @IBAction func addButtonTapped(sender: UIButton) {
        if let indexPath = selectedWorkoutElementIndexPath {
            viewModel.insertElementAtRowToTimelineElements(indexPath.row)
        }
    }
    
    @IBAction func trashButtonTapped(sender: UIBarButtonItem) {
        viewModel.clearTimeLine()
    }
}

extension MainViewController: UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.workoutElementsCollectionView {
            return viewModel.predefinedElementsCount()
        } else {
            return viewModel.timeLineElements.count
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellReuseIdentifier, forIndexPath: indexPath) as! WorkountElementCell
        if collectionView == self.workoutElementsCollectionView {
            let cellViewModel = viewModel.workoutElementCellViewModelForRow(indexPath.row)
            cell.configureWithViewModel(cellViewModel)
            cell.layer.borderColor = UIColor.blackColor().CGColor
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
            collectionView.cellForItemAtIndexPath(indexPath)?.layer.borderWidth = 2.0
            selectedWorkoutElementIndexPath = indexPath
        }
    }
    
    func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        if collectionView == self.workoutElementsCollectionView {
            collectionView.cellForItemAtIndexPath(indexPath)?.layer.borderWidth = 0.0
        }
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: 100, height: 50)
    }
}
