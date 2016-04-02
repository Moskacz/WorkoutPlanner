//
//  TimeLineCollectionViewLayout.swift
//  WorkoutPlanner
//
//  Created by Michał Moskała on 22.02.2016.
//  Copyright © 2016 Michal Moskala. All rights reserved.
//

import UIKit

class TimeLineCollectionViewLayout: UICollectionViewFlowLayout {
    
    override func initialLayoutAttributesForAppearingItemAtIndexPath(itemIndexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        let attributes = layoutAttributesForItemAtIndexPath(itemIndexPath)
        
        attributes?.center = CGPoint(x: CGRectGetMidX(collectionView!.bounds), y: CGRectGetMaxY(collectionView!.bounds))
        attributes?.transform = CGAffineTransformRotate(CGAffineTransformMakeScale(0.2, 0.2), CGFloat(M_PI))
        
        return attributes
    }
    
    override func finalLayoutAttributesForDisappearingItemAtIndexPath(itemIndexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        let attribues = super.finalLayoutAttributesForDisappearingItemAtIndexPath(itemIndexPath)
        
        attribues?.alpha = 0.0
        attribues?.center = CGPoint(x: CGRectGetMidX(collectionView!.bounds), y: CGRectGetMaxY(collectionView!.bounds))
        attribues?.transform = CGAffineTransformRotate(CGAffineTransformMakeScale(0.2, 0.2), CGFloat(-M_PI))
        
        return attribues
    }

}
