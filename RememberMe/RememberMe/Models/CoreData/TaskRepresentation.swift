//
//  TaskRepresentation.swift
//  RememberMe
//
//  Created by Joe Veverka on 7/12/20.
//  Copyright © 2020 Joe Veverka. All rights reserved.
//

import Foundation
import Firebase

struct TaskRepresentation {
    let title: String
    let identifier: String
    let ref: DatabaseReference?
    let taskType: String
    let timeStamp: Date
    var complete: Bool
    
    
    
}
