//
//  CoreDataStack.swift
//  RememberMe
//
//  Created by Joe Veverka on 7/12/20.
//  Copyright © 2020 Joe Veverka. All rights reserved.
//
import Foundation
import CoreData

class CoreDataStack {
    // Singleton
    static let shared = CoreDataStack()
    
    lazy var container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Journal")
        container.loadPersistentStores { (_, error) in
            if let error = error {
                fatalError("Error loading persistent store: \(error)")
            }
        }
        return container
    }()
    
    var mainContext: NSManagedObjectContext {
        return container.viewContext
    }
    
    func save(context: NSManagedObjectContext = CoreDataStack.shared.mainContext) throws {
        var error: Error?
        context.performAndWait {
            do {
                try context.save()
                
            } catch let saveError {
                error = saveError
            }
        }
        if let error = error { throw error }
    }
}
