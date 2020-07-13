//
//  Note.swift
//  Remember Me
//
//  Created by Marissa Gonzales on 6/6/20.
//  Copyright © 2020 Joe Veverka. All rights reserved.
//

import Foundation
import Firebase

struct Task {
    
    let name: String
    let key: String
    let ref: DatabaseReference?
    var completed: Bool
    let addedByUser: String
    var date: Date
    
    init(name: String, addedByUser: String, completed: Bool = false, key: String = "", date: Date = Date()) {
        self.ref = nil
        self.name = name
        self.addedByUser = addedByUser
        self.completed = completed
        self.date = date
        self.key = key
    }
    
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: AnyObject],
            let name = value["name"] as? String,
            let addedByUser = value["addedByUser"] as? String,
            let date = value["date"] as? Date,
            let completed = value["completed"] as? Bool else {
                return nil
        }
        
        self.ref = snapshot.ref
        self.key = snapshot.key
        self.name = name
        self.addedByUser = addedByUser
        self.completed = completed
        self.date = date
    }
    
    func toAnyObject() -> Any {
        return [
            "name": name,
            "addedByUser": addedByUser,
            "date": date,
            "completed": completed
        ]
    }
    
    
}


