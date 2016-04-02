//
//  AddElementViewController.swift
//  WorkoutPlanner
//
//  Created by Michał Moskała on 11.02.2016.
//  Copyright © 2016 Michal Moskala. All rights reserved.
//

import UIKit
import Bond

class AddElementViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var minutesTextField: UITextField!
    @IBOutlet weak var secondsTextField: UITextField!
    @IBOutlet weak var donebarButton: UIBarButtonItem!
    @IBOutlet weak var colorPlaceholderView: UIView!
    @IBOutlet weak var soundNameLabel: UILabel!
    
    let viewModel = AddElementViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colorPlaceholderView.backgroundColor = UIColor.clearColor()
        setupBinding()
    }
    
    @IBAction func doneButtonTapped(sender: UIBarButtonItem) {
        viewModel.createNewWorkoutElement()
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func cancelButtonTapped(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let destinationVC = segue.destinationViewController as? ColorPickerViewController {
            destinationVC.delegate = self
        }
        if let destinationVC = segue.destinationViewController as? SelectSoundViewController {
            destinationVC.delegate = self
        }
    }
    
    private func setupBinding() {
        nameTextField.bnd_text.bindTo(viewModel.name)
        minutesTextField.bnd_text.bindTo(viewModel.minutes)
        secondsTextField.bnd_text.bindTo(viewModel.seconds)
        viewModel.formValid.bindTo(donebarButton.bnd_enabled)
        viewModel.soundName.bindTo(soundNameLabel.bnd_text)
    }
}

extension AddElementViewController: ColorPickerDelegate {
    
    func colorPickerDidPickColor(color: UIColor) {
        colorPlaceholderView.backgroundColor = color
        viewModel.color.next(color)
        navigationController?.popViewControllerAnimated(true)
    }
}

extension AddElementViewController: SelectSoundDelegate {
    
    func didSelectSoundWithName(name: String) {
        viewModel.soundName.next(name)
    }
}