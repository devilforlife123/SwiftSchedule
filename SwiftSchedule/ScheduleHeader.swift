//
//  ScheduleHeader.swift
//  SwiftSchedule
//
//  Created by suraj poudel on 4/05/2016.
//  Copyright © 2016 suraj poudel. All rights reserved.
//

import Foundation
import UIKit

class ScheduleHeader:UICollectionReusableView{
    
    @IBOutlet weak var titleLabel:UILabel!
    @IBOutlet weak var verticalSeparatorView:UIView?
    @IBOutlet weak var verticalSeparatorViewWidthConstraint:NSLayoutConstraint?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if let verticalConstraint = verticalSeparatorViewWidthConstraint{
            verticalConstraint.constant = 0.5
        }
    }
    
    
}