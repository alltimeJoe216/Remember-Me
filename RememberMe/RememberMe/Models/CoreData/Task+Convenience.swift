//
//  Task+Convenience.swift
//  RememberMe
//
//  Created by Joe Veverka on 7/12/20.
//  Copyright © 2020 Joe Veverka. All rights reserved.
//

enum TaskType: String, CaseIterable {
    case family = "Family"
    case work = "Work"
    case shopping = "Shopping"
    case personal = "Personal"
    case inbox = "inbox"
}

import Foundation

extension Task {
    
    var taskRepresentation: TaskRepresentation? {
        
        guard let id = identifier,
            let title = title,
            let timestamp = date,
            let taskType = taskType else {
                return nil
        }
        
        return TaskRepresentation(title: title, identifier: id.uuidString, taskType: taskType, timeStamp: timestamp)
    }
    
    @discardableResult convenience init(identifier: UUID = UUID(), title: String, )
    
}
