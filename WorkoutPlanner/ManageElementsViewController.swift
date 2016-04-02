//
//  ManageElementsViewController.swift
//  WorkoutPlanner
//
//  Created by Michał Moskała on 11.02.2016.
//  Copyright © 2016 Michal Moskala. All rights reserved.
//

import UIKit
import Bond

class ManageElementsViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    let viewModel = ManageElementsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupObservers()
    }
    
    private func setupCollectionView() {
        let cellNib = UINib(nibName: "WorkoutElementCell", bundle: nil)
        collectionView.registerNib(cellNib, forCellWithReuseIdentifier: "cell")
    }
    
    private func setupObservers() {
        viewModel.workoutElementsModel.reloadElements.observe {_ in 
            self.collectionView.reloadData()
        }
    }
}

extension ManageElementsViewController: UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.elementsCount()
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! WorkountElementCell
        cell.configureWithViewModel(viewModel.cellViewModel(indexPath.row))
        return cell
    }
}