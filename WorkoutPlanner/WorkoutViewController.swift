//
//  WorkoutViewController.swift
//  WorkoutPlanner
//
//  Created by Michał Moskała on 13.02.2016.
//  Copyright © 2016 Michal Moskala. All rights reserved.
//

import UIKit

class WorkoutViewController: UIViewController {

    @IBOutlet weak var countdownLabel: UILabel!
    @IBOutlet weak var timeLeftTitleLabel: UILabel!
    @IBOutlet weak var timeLeftLabel: UILabel!
    @IBOutlet weak var progressTitleLabel: UILabel!
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var pusheenImageView: UIImageView!
    
    var viewModel: WorkoutViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        setupPusheenAnimation()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.start()
    }
    
    private func bindViewModel() {
        viewModel.progressText.bindTo(progressLabel.bnd_text)
        viewModel.timeLeftText.bindTo(timeLeftLabel.bnd_text)
        viewModel.countDownText.bindTo(countdownLabel.bnd_text)
        viewModel.titleLabelsHidden.bindTo(timeLeftTitleLabel.bnd_hidden)
        viewModel.titleLabelsHidden.bindTo(progressTitleLabel.bnd_hidden)
        viewModel.pusheenAnimating.observe {
            if $0 {
                self.pusheenImageView.startAnimating()
            } else {
                self.pusheenImageView.stopAnimating()
            }
        }
    }
    
    private func setupPusheenAnimation() {
        let frames = [UIImage(named: "pusheen1")!, UIImage(named: "pusheen2")!, UIImage(named: "pusheen3")!, UIImage(named: "pusheen4")!]
        pusheenImageView.animationImages = frames
        pusheenImageView.animationDuration = 1.0
    }
    
    @IBAction func stopTapped(sender: UIButton) {
        viewModel.timer?.invalidate()
        dismissViewControllerAnimated(true, completion: nil)
    }
}
