//
//  ScheduleViewController.swift
//  SwiftSchedule
//
//  Created by suraj poudel on 4/05/2016.
//  Copyright © 2016 suraj poudel. All rights reserved.
//

import Foundation
import UIKit

class ScheduleViewController:UICollectionViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "ConFerence Schedule"
        
        //Create the headernib and then register them to the collectionView
        let headerNib = UINib(nibName: "ScheduleHeader", bundle: nil)
        collectionView?.registerNib(headerNib, forSupplementaryViewOfKind: "TrackHeader", withReuseIdentifier: "ScheduleHeader")
        collectionView?.registerNib(headerNib, forSupplementaryViewOfKind: "HourHeader", withReuseIdentifier: "ScheduleHeader")
        
        //get the dataSource
        
        let dataSource = collectionView?.dataSource as! ScheduleDataSource
        
        dataSource.cellCompletionHandler = {(cell:ScheduleCell,indexPath:NSIndexPath,session:Session) in
            
            cell.nameLabel.text = session.name
            
        }
        
        dataSource.headerCompletionHandler = {(header:ScheduleHeader,indexPath:NSIndexPath,kind:String) in
            
            if kind == "TrackHeader"{
                header.titleLabel.text = dataSource.tracksInSchedule[indexPath.item]
            }else if kind == "HourHeader"{
                header.titleLabel.text = dataSource.hoursInSchedule[indexPath.item]
            }
            
        }
    }
}