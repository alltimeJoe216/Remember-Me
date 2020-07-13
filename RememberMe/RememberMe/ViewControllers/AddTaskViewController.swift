//
//  AddTaskViewController.swift
//  RememberMe
//
//  Created by Joe Veverka on 7/11/20.
//  Copyright © 2020 Joe Veverka. All rights reserved.
//

import UIKit
import Firebase

class AddTaskViewController: UIViewController {
    
    var user: User!
    let ref = Database.database().reference(withPath: "tasks")
    let usersRef = Database.database().reference(withPath: "online")
    
    @IBOutlet weak var textField: UITextField!
    
    var task: Task?
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func saveTask(_ sender: UIButton) {
        
        // 1
        guard let text = textField.text else { return }
        
        
        let newTask = Task(name: text,
                                      addedByUser: self.user.email,
                                      completed: false)
        
        let taskRef = self.ref.child(text.lowercased())
        
        taskRef.setValue(newTask.toAnyObject())
    }    
}

