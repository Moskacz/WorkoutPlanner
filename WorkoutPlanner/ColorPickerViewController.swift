//
//  ColorPickerViewController.swift
//  WorkoutPlanner
//
//  Created by Michał Moskała on 11.02.2016.
//  Copyright © 2016 Michal Moskala. All rights reserved.
//

import UIKit

protocol ColorPickerDelegate: class {
    func colorPickerDidPickColor(color: UIColor)
}

class ColorPickerViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    let viewModel = ColorPickerViewModel()
    weak var delegate: ColorPickerDelegate?
    var pickedColor: UIColor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        collectionView.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    }
    
    @IBAction func doneButtonTapped(sender: UIBarButtonItem) {
        if let color = pickedColor {
            delegate?.colorPickerDidPickColor(color)
        }
    }
}

extension ColorPickerViewController: UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.colors.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath)
        cell.backgroundColor = viewModel.colors[indexPath.row]
        cell.layer.borderColor = UIColor.orangeColor().CGColor
        cell.layer.borderWidth = 0.0
        return cell
    }
}

extension ColorPickerViewController: UICollectionViewDelegate {
    
    func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        collectionView.cellForItemAtIndexPath(indexPath)?.layer.borderWidth = 0.0
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        collectionView.cellForItemAtIndexPath(indexPath)?.layer.borderWidth = 2.0
        pickedColor = viewModel.colors[indexPath.row]
    }
    
}
