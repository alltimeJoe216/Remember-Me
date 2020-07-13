//
//  TodaysTaskTableViewCell.swift
//  RememberMe
//
//  Created by Joe Veverka on 7/11/20.
//  Copyright © 2020 Joe Veverka. All rights reserved.
//

import UIKit

class TodaysTaskTableViewCell: UITableViewCell {

    @IBOutlet weak var taskTypeColorView: UIView!
    @IBOutlet weak var taskLabel: UILabel!
    @IBOutlet weak var taskCompletedOrNotButton: UIButton!
    
    var task: Task?  {
        didSet {
            updateViews()
        }
    }
 
    func updateViews() {
        guard let task = task else { return }
        taskLabel.text = task.name

    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
