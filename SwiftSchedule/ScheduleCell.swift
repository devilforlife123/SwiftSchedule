//
//  ScheduleCell.swift
//  SwiftSchedule
//
//  Created by suraj poudel on 4/05/2016.
//  Copyright © 2016 suraj poudel. All rights reserved.
//

import Foundation
import UIKit

class ScheduleCell:UICollectionViewCell{
    
    @IBOutlet weak var nameLabel:UILabel!
    @IBOutlet weak var timeLabel:UILabel!
    @IBOutlet weak var separator:UIView!
    @IBOutlet weak var separatorHeightConstraint:NSLayoutConstraint?
    @IBOutlet weak var itemBackgroundView:UIView?
    
    //Awake from Nib
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if let constraint = separatorHeightConstraint{
            constraint.constant = 0.5
        }
        if let view = itemBackgroundView{
            let layer = view.layer
            layer.cornerRadius = 4
            layer.borderWidth = 1
            layer.borderColor = UIColor(red: 0,green: 104/255,blue:56/255,alpha:1).CGColor
            layer.masksToBounds = true
            
        }
    }
    
    
}