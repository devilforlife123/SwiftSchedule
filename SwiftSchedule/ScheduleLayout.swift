//
//  ScheduleLayout.swift
//  SwiftSchedule
//
//  Created by suraj poudel on 5/05/2016.
//  Copyright © 2016 suraj poudel. All rights reserved.
//

import Foundation
import UIKit

struct Frame{
    let indexPath:NSIndexPath
    let rect:CGRect
}
class ScheduleLayout:UICollectionViewLayout{
    
    
    let widthPerHour:CGFloat = 180.0
    let trackHeaderWidth:CGFloat = 120.0
    let hourHeaderHeight:CGFloat = 40.0

    //Now create variables that hold the various Frames
    //we need to create them because we will iterate over and populate them in the respective containers and also when we are populating the eventual layoutAttributes we need to know the indexPath and the rect of the frame 
    
    var sessionFrames:[Frame] = []
    var trackHeaderFrames:[Frame] = []
    var hourHeaderFrames:[Frame] = []
    
    
    lazy var dataSource:ScheduleDataSource = {
        return self.collectionView!.dataSource as! ScheduleDataSource
    }()
    
    override func collectionViewContentSize() -> CGSize {
        //It is always advisable to call the superview's class
        super.collectionViewContentSize()
        
        //Height of the collectionView and how below it is from the contentInset
        let height = collectionView!.bounds.height - collectionView!.contentInset.top
        let width:CGFloat = widthPerHour * CGFloat(dataSource.numberOfHoursInSchedule)
        return CGSize(width: width, height: height)
        
    }
    
    //In the prepareLayout populate with allthe frames
    override func prepareLayout() {
        super.prepareLayout()
        
        if sessionFrames.isEmpty{
            //populate the frames
            for section in 0..<collectionView!.numberOfSections(){
                for item in 0..<collectionView!.numberOfItemsInSection(section){
                    //Create the indexPath
                    let indexPath = NSIndexPath(forItem: item, inSection: section)
                    //Now need to create the frame 
                    let rect = frameForSessionAtIndexPath(indexPath)
                    let sessionFrame = Frame(indexPath: indexPath, rect: rect)
                    sessionFrames.append(sessionFrame)
                }
            }
        }
        
        if hourHeaderFrames.isEmpty{
            
            for item in 0..<dataSource.numberOfHoursInSchedule{
                let indexPath = NSIndexPath(forItem: item, inSection: 0)
                let rect = frameForHourHeaderAtIndexPath(indexPath)
                let hourFrame = Frame(indexPath: indexPath, rect: rect)
                hourHeaderFrames.append(hourFrame)
            }
        }
        
        if trackHeaderFrames.isEmpty{
            for item in 0..<dataSource.numberOfTracksInSchedule{
                let indexPath = NSIndexPath(forItem: item, inSection: 0)
                let rect = frameForTrackHeaderAtIndexPath(indexPath)
                let trackFrame = Frame(indexPath: indexPath, rect: rect)
                trackHeaderFrames.append(trackFrame)
            }
        }
        
    }
    
    private func frameForTrackHeaderAtIndexPath(indexPath:NSIndexPath)->CGRect{
        
         let height = (collectionViewContentSize().height - hourHeaderHeight)/CGFloat(dataSource.numberOfTracksInSchedule)
          print("Content height is \(collectionViewContentSize().height)")
         let width = trackHeaderWidth
         let y = CGFloat(indexPath.item) * height + hourHeaderHeight
        return CGRect(x: 0, y: y, width: width, height: height)
        
    }
    
    private func frameForHourHeaderAtIndexPath(indexPath:NSIndexPath)->CGRect{
        let height = collectionViewContentSize().height
        let width = widthPerHour
        let x = trackHeaderWidth + CGFloat(indexPath.item) * widthPerHour
        return CGRect(x: x, y: 0, width: width, height: height)
    }
    
    private func frameForSessionAtIndexPath(indexPath:NSIndexPath)->CGRect{
        let session = dataSource.sessionAtIndexPath(indexPath)
        let height = (collectionViewContentSize().height - hourHeaderHeight)/CGFloat(dataSource.numberOfTracksInSchedule)
        let width = CGFloat(session.length) * widthPerHour
        let x = trackHeaderWidth + CGFloat(session.hour + session.offset) * widthPerHour
        let y = CGFloat(indexPath.item) * height + hourHeaderHeight
        
        return CGRect(x: x, y: y, width: width, height: height)
    }
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        super.layoutAttributesForElementsInRect(rect)
        
        var layoutAttributes:[UICollectionViewLayoutAttributes] = []
        for frame in sessionFrames{
            //If the frame intersects with the stipulated rect
            if CGRectIntersectsRect(frame.rect, rect){
                //Then create a layoutAttribute which is an instance of UICollectionViewLayoutAttributes with indexPath as instance variable
                let layoutAttribute = UICollectionViewLayoutAttributes(forCellWithIndexPath: frame.indexPath)
                
                //set the frame of the layout attribute to be the rect frame
                layoutAttribute.frame = frame.rect
                layoutAttributes.append(layoutAttribute)
            }
        }
        
        for frame in trackHeaderFrames{
            if CGRectIntersectsRect(frame.rect, rect){
                let layoutAttribute = UICollectionViewLayoutAttributes(forSupplementaryViewOfKind: "TrackHeader", withIndexPath: frame.indexPath)
                layoutAttribute.zIndex = -1
                layoutAttribute.frame = frame.rect
                layoutAttributes.append(layoutAttribute)
            }
        }
        
        for frame in hourHeaderFrames{
            if CGRectIntersectsRect(frame.rect, rect){
                let layoutAttribute = UICollectionViewLayoutAttributes(forSupplementaryViewOfKind: "HourHeader", withIndexPath: frame.indexPath)
                layoutAttribute.zIndex = -1
                layoutAttribute.frame = frame.rect
                layoutAttributes.append(layoutAttribute)
            }
        }
        
        return layoutAttributes
    }
    
}