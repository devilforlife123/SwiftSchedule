//
//  Session.swift
//  SwiftSchedule
//
//  Created by suraj poudel on 4/05/2016.
//  Copyright © 2016 suraj poudel. All rights reserved.
//


import Foundation
import UIKit

class Session{
    
    let time:String
    let name:String
    let room:String
    let hour:Float
    let offset:Float
    let length:Float
    
    init(time:String,name:String,room:String,hour:Float,offset:Float,length:Float){
        self.time = time
        self.name = name
        self.room = room
        self.hour = hour
        self.offset = offset
        self.length = length
    }
    
    convenience init(dictionary:[String:AnyObject]){
        let time = dictionary["Time"] as! String
        let name = dictionary["Name"] as! String
        let room = dictionary["Room"] as! String
        let hour = dictionary["Hour"] as! NSString
        let offset = dictionary["Offset"] as! NSString
        let length = dictionary["Length"] as! NSString
        
        self.init(time:time,name: name ,room: room ,hour: hour.floatValue,offset: offset.floatValue,length: length.floatValue)
    }

}