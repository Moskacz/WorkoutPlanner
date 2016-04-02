//
//  SelectSoundViewController.swift
//  WorkoutPlanner
//
//  Created by Michał Moskała on 13.02.2016.
//  Copyright © 2016 Michal Moskala. All rights reserved.
//

import UIKit

protocol SelectSoundDelegate: class {
    func didSelectSoundWithName(name: String)
}

class SelectSoundViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    weak var delegate: SelectSoundDelegate?
    
    let soundNames = ["odpoczywaj", "cwicz"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
}

extension SelectSoundViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return soundNames.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell")!
        cell.textLabel?.text = soundNames[indexPath.row]
        return cell
    }
}

extension SelectSoundViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let soundName = soundNames[indexPath.row]
        delegate?.didSelectSoundWithName(soundName)
        navigationController?.popViewControllerAnimated(true)
    }
    
}


