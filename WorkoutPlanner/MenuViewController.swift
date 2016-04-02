//
//  MenuViewController.swift
//  WorkoutPlanner
//
//  Created by Michał Moskała on 09.02.2016.
//  Copyright © 2016 Michal Moskala. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    weak var containerViewController: ContainerViewController?
    
    @IBAction func manageElementsTapped(sender: UIButton) {
        containerViewController?.showManageElementsViewController()
    }
    
    
    
}
