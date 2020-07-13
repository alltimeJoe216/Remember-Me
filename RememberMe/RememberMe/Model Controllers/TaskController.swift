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
    case failedDecode
    case failedEncode
    case noDecode
}

typealias CompletionHandler = (Result<Bool, NetworkError>) -> Void
let fireBaseURL = URL(string: "https://www.google.com")!

class TaskController {
    init() {
        //        fetchTasksFromServer()
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
                try self.updateTasks(with: taskRepresentations)
            } catch {
                NSLog("Error deocding entries from Firebase: \(error)")
                completion(.failure(.noDecode))
            }
        }.resume()
    }
    
    //MARK: - Delete
    
    func deleteTaskFromServer(_ task: Task, completion: @escaping CompletionHandler = { _ in }) {
        guard let uuid = task.identifier else {
            completion(.failure(.noIdentifier))
            return
        }
        
        // https://tasks-3f211.firebaseio.com/[uuid].json
        let requestURL = fireBaseURL.appendingPathComponent(uuid.uuidString).appendingPathExtension("json")
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = "DELETE"
        
        URLSession.shared.dataTask(with: request) { _, _, error in
            if let error = error {
                NSLog("Error deleting task from server \(task): \(error)")
                completion(.failure(.otherError))
                return
            }
            
            completion(.success(true))
        }.resume()
    }
    
    //MARK: - Send Task To Server
    
    func sendTaskToServer(task: Task, completion: @escaping CompletionHandler = { _ in }) {
        guard let uuid = task.identifier else {
            completion(.failure(.noIdentifier))
            return
        }
        
        // https://tasks-3f211.firebaseio.com/[uuid].json
        let requestURL = fireBaseURL.appendingPathComponent(uuid.uuidString).appendingPathExtension("json")
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = "PUT"
        
        do {
            guard let representation = task.taskRepresentation else {
                completion(.failure(.failedEncode))
                return
            }
            request.httpBody = try JSONEncoder().encode(representation)
        } catch {
            NSLog("Error encoding task \(task): \(error)")
            completion(.failure(.failedEncode))
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                NSLog("Error sending task to server \(task): \(error)")
                completion(.failure(.otherError))
                return
            }
            
            completion(.success(true))
        }.resume()
    }
    
    
    //MARK: - UpdateWithRep
    
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
                    self.update(task: task, with: representation)
                    tasksToCreate.removeValue(forKey: id)
                }
            } catch let fetchError {
                error = fetchError
            }
            for representation in tasksToCreate.values {
                Task(taskRepresentation: representation, context: context)
            }
        }
        if let error = error { throw error }
        try CoreDataStack.shared.save(context: context)
    }
    
    private func update(task: Task, with representation: TaskRepresentation) {
        task.title = representation.title
        task.taskType = representation.taskType
        task.date = representation.timeStamp
        task.complete = representation.complete
    }
}
