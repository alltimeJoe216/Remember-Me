//
//  TodaysTaskTableViewCell.swift
//  RememberMe
//
//  Created by Joe Veverka on 7/11/20.
//  Copyright © 2020 Joe Veverka. All rights reserved.
//

import UIKit

class TodaysTaskTableViewCell: UITableViewCell {
    static let identifier = "TodayTaskCell"

    @IBOutlet weak var taskTypeColorView: UIView!
    @IBOutlet weak var taskLabel: UILabel!
    @IBOutlet weak var taskCompletedOrNotButton: UIButton!
 
    func updateViews() {

    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
