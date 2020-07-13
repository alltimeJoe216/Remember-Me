//
//  AddTaskViewController.swift
//  RememberMe
//
//  Created by Joe Veverka on 7/11/20.
//  Copyright © 2020 Joe Veverka. All rights reserved.
//

import UIKit
import Firebase

protocol TaskWasAdded {
    func taskWasAdded(_ task: Task)
}

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
        guard let text = textField.text else { return }
        let newTask = Task(name: text)
        delegate?.taskWasAdded(newTask!)
        dismiss(animated: true, completion: nil)
    }
    
    var delegate: TaskWasAdded?
}

