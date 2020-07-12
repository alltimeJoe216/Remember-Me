//
//  TaskController.swift
//  RememberMe
//
//  Created by Joe Veverka on 7/12/20.
//  Copyright © 2020 Joe Veverka. All rights reserved.
//

import UIKit
import CoreData

enum NetworkError: Error {
    case noIdentifier
    case otherError
    case noData
    case noDecode
    case noEncode
    case noRep
}

typealias CompletionHandler = (Result<Bool, NetworkError>) -> Void
let fireBaseURL = URL(string: "https://www.google.com")!

class TaskController {
    init() {
        fetchTasksFromServer()
    }
    //MARK: - Fetch
    func fetchTasksFromServer(completion: @escaping CompletionHandler = { _ in }) {
        let requestURL = fireBaseURL.appendingPathExtension("json")
        
        URLSession.shared.dataTask(with: requestURL) { data, _, error in
            if let error = error {
                NSLog("Error fetching tasks: \(error)")
                completion(.failure(.otherError))
                return
            }
            
            guard let data = data else {
                NSLog("No data returned from Firebase (fetching entries).")
                completion(.failure(.noData))
                return
            }
            
            do {
                let taskRepresentations = Array(try JSONDecoder().decode([String : TaskRepresentation].self, from: data).values)
                //MARK: - TODO: update tasks
                //                try self.updateTasks(with: taskRepresentations)
            } catch {
                NSLog("Error deocding entries from Firebase: \(error)")
                completion(.failure(.noDecode))
            }
        }.resume()
    }
    
    //MARK: - UpdateWithRep
    
    // Update Tasks
    private func updateTasks(with representations: [TaskRepresentation]) throws {
        
        let identifiersToFetch = representations.compactMap { UUID(uuidString: $0.identifier) }
        let representationsByID = Dictionary(uniqueKeysWithValues: zip(identifiersToFetch, representations))
        var tasksToCreate = representationsByID
        
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "identifier IN %@", identifiersToFetch)
        
        let context = CoreDataStack.shared.container.newBackgroundContext()
        
        var error: Error?
        
        context.performAndWait {
            do {
                let existingTasks = try context.fetch(fetchRequest)
                
                for task in existingTasks {
                    guard let id = task.identifier,
                        let representation = representationsByID[id] else { continue }
                    //MARK: - TODO
//                    self.update(entry: task, with: representation)
                    tasksToCreate.removeValue(forKey: id)
                }
            } catch let fetchError {
                error = fetchError
            }
            for representation in tasksToCreate.values {
                //MARK: - TODO: Task rep inits
//                Entry(entryRepresentation: representation, context: context)
            }
        }
        if let error = error { throw error }
        try CoreDataStack.shared.save(context: context)
    }
}
