//
//  Group.swift
//  SwiftSchedule
//
//  Created by suraj poudel on 4/05/2016.
//  Copyright © 2016 suraj poudel. All rights reserved.
//

import Foundation


class Group{
    
    let sessions:[Session]
    let header:String
    
    init(sessions:[Session],header:String){
        self.sessions = sessions
        self.header = header
    }
    
    convenience init(dict:[String:AnyObject]){

        let header = dict["Header"] as! String
        let sessionsArray = dict["Sessions"] as! [[String:AnyObject]]
        var sessions:[Session] = []
        for dict in sessionsArray{
            let session = Session(dictionary: dict)
            sessions.append(session)
        }
        self.init(sessions:sessions,header: header)
    }
    
}