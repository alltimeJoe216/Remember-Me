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
    case inbox = "Inbox"
}

import Foundation
import CoreData

extension Task {
    
    var taskRepresentation: TaskRepresentation? {
        
        guard let id = identifier,
            let title = title,
            let timeStamp = date,
            let taskType = taskType else {
                return nil
        }
        
        return TaskRepresentation(title: title, identifier: id.uuidString, taskType: taskType, timeStamp: timeStamp, complete: complete)
    }
    
    @discardableResult convenience init(identifier: UUID = UUID(),
                                        title: String,
                                        timeStamp: Date = Date(),
                                        taskType: TaskType = .personal,
                                        complete: Bool = false,
                                        context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        self.init(context: context)
        self.identifier = identifier
        self.title = title
        self.taskType = taskType.rawValue
        self.complete = complete
    }
    
    @discardableResult convenience init?(taskRepresentation: TaskRepresentation, context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        guard let identifier = UUID(uuidString: taskRepresentation.identifier),
            let taskType = TaskType(rawValue: taskRepresentation.taskType) else { return nil }
        
        self.init(identifier: identifier, title: taskRepresentation.title, timeStamp: taskRepresentation.timeStamp, taskType: taskType, complete: taskRepresentation.complete)
    }
}
