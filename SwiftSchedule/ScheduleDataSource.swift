//
//  ScheduleDataSource.swift
//  SwiftSchedule
//
//  Created by suraj poudel on 4/05/2016.
//  Copyright © 2016 suraj poudel. All rights reserved.
//

import Foundation
import UIKit

typealias CellCompletionHandler = (cell:ScheduleCell,indexPath:NSIndexPath,session:Session)->()
typealias HeaderCompletionHandler = (header:ScheduleHeader,indexPath:NSIndexPath,kind:String)->()



class ScheduleDataSource:NSObject,UICollectionViewDataSource{
    
  
    //create the completionHandler variables
    
    var cellCompletionHandler:CellCompletionHandler? = nil
    var headerCompletionHandler:HeaderCompletionHandler? = nil
    
    
    let numberOfHoursInSchedule = 11
    let numberOfTracksInSchedule = 3
    
    
    //Variables for the Tracks and Hourheader strings
    var tracksInSchedule = ["Beginner","Intermediate","Advanced"]
    var hoursInSchedule = ["08:00", "09:00", "10:00", "11:00", "12:00", "13:00", "14:00", "15:00", "16:00", "17:00", "18:00"]
    
    private lazy var schedule:[Group] = {
        
        var groups:[Group] = []
        if let path = NSBundle.mainBundle().pathForResource("Schedule", ofType: "plist"){
            if let contents = NSArray(contentsOfFile: path) as? [[String:AnyObject]]{
                for dictionary in contents{
                    let group = Group(dict: dictionary)
                    groups.append(group)
                }
            }
        }
        return groups
        
    }()
    
    
    //CollectionViewDataSource And Delegate functions
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return schedule[section].sessions.count
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return schedule.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ScheduleCell", forIndexPath: indexPath) as! ScheduleCell
        let session = schedule[indexPath.section].sessions[indexPath.item]
        
        //Now we can call the cellCompletionHandler
        
        //This is the execution
        if let cellCompletion = cellCompletionHandler{
            cellCompletion(cell: cell, indexPath: indexPath, session: session)
        }
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "ScheduleHeader", forIndexPath: indexPath) as! ScheduleHeader
        if let headerCompletion = headerCompletionHandler{
            headerCompletion(header: header, indexPath: indexPath, kind: kind)
        }
        
        return header 
    }
    
    func sessionAtIndexPath(indexPath:NSIndexPath)->Session{
        return schedule[indexPath.section].sessions[indexPath.item]
    }
    
    
    
    
}