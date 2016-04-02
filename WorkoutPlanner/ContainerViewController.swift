//
//  ContainerViewController.swift
//  WorkoutPlanner
//
//  Created by Michał Moskała on 09.02.2016.
//  Copyright © 2016 Michal Moskala. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController {
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var sideView: UIView!
    @IBOutlet weak var topViewControllerTrailingSpaceConstraint: NSLayoutConstraint!
    var mainViewController: MainViewController?
    var overlayView: UIView?
    
    // MARK: side view
    
    var sideViewVisible: Bool {
        return topViewControllerTrailingSpaceConstraint.constant > 0.0
    }
    
    func toggleSideView() {
        if sideViewVisible {
            hideSideView()
        } else {
            showSideView()
        }
    }
    
    private func showSideView() {
        topViewControllerTrailingSpaceConstraint.constant = CGRectGetWidth(sideView.bounds)
        setupOverlayTappableLayerOnTopView()
        UIView.animateWithDuration(0.2) { () -> Void in
            self.view.layoutIfNeeded()
        }
    }
    
    private func hideSideView() {
        topViewControllerTrailingSpaceConstraint.constant = 0.0
        overlayView?.removeFromSuperview()
        overlayView = nil
        UIView.animateWithDuration(0.2) { () -> Void in
            self.view.layoutIfNeeded()
        }
    }
    
    private func setupOverlayTappableLayerOnTopView() {
        overlayView = UIView()
        overlayView!.translatesAutoresizingMaskIntoConstraints = false
        topView.addSubview(overlayView!)
        
        let views = ["overlayView": overlayView!]
        let verticalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|[overlayView]|", options: [], metrics: nil, views: views)
        let horizontalConstraint = NSLayoutConstraint.constraintsWithVisualFormat("H:|[overlayView]|", options: [], metrics: nil, views: views)
        
        topView.addConstraints(verticalConstraints)
        topView.addConstraints(horizontalConstraint)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: Selector("overlayLayerViewTapped"))
        overlayView?.addGestureRecognizer(tapGestureRecognizer)
    }
    
    private dynamic func overlayLayerViewTapped() {
        hideSideView()
    }
    
    // MARK: navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let navController = segue.destinationViewController as? UINavigationController {
            if let mainController = navController.topViewController as? MainViewController {
                mainController.containerViewController = self
                mainViewController = mainController
            }
        }
        
        if let menuViewController = segue.destinationViewController as? MenuViewController {
            menuViewController.containerViewController = self
        }
    }
    
    func showManageElementsViewController() {
        hideSideView()
        mainViewController?.performSegueWithIdentifier("ShowManageElementsViewController", sender: nil)
    }
}
