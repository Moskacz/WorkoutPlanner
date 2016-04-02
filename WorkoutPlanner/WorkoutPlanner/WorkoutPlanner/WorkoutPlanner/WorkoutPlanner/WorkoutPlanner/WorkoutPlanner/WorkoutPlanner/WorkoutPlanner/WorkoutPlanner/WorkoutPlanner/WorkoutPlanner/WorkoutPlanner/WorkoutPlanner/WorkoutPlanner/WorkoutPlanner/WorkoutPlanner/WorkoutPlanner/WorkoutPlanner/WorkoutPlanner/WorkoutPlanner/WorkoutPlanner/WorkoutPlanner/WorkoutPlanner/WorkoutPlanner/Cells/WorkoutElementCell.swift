//
//  WorkoutElementCell.swift
//  WorkoutPlanner
//
//  Created by Michał Moskała on 30.01.2016.
//  Copyright © 2016 Michal Moskala. All rights reserved.
//

import UIKit

class WorkountElementCell: UICollectionViewCell {
    
    @IBOutlet weak var mainLabel: UILabel!
    
    class func cell() -> WorkountElementCell {
        let views = NSBundle.mainBundle().loadNibNamed("WorkoutElementCell", owner: nil, options: nil)
        return views.first as! WorkountElementCell
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.borderColor = UIColor.blackColor().CGColor
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        mainLabel.text = nil
        contentView.backgroundColor = UIColor.whiteColor()
    }
    
    func configureWithViewModel(viewModel: WorkoutElementCellViewModel) {
        mainLabel.text = viewModel.getText()
        contentView.backgroundColor = viewModel.getBackgroundColor()
    }
    
   override var selected: Bool {
        didSet {
            if selected {
                layer.borderWidth = 3.0
            } else {
                layer.borderWidth = 0.0
            }
        }
    }
}