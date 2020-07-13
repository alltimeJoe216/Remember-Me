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
    
    @IBOutlet weak var textField: UITextField!
    let ref = Database.database().reference(withPath: "task")
    
    var task: Task?
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func saveTask(_ sender: UIButton) {
        
        
         // 1
         guard let task = task,
            let text = textField.text else { return }
         
         // 2
         let newTask = Task(title: "\(text)")
        // 3
         let groceryItemRef = self.ref.child(text.lowercased())
         
         // 4
//         groceryItemRef.setValue(newTask.toAnyObject())
         
         
        
    }
    
}
