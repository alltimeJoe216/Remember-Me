//
//  TaskTypeTableViewCell.swift
//  RememberMe
//
//  Created by Joe Veverka on 7/11/20.
//  Copyright © 2020 Joe Veverka. All rights reserved.
//

import UIKit

//let familyList: List = List(
//
//let workList:
//
//let inboxList:
//
//let personalList:
//
//let shoppingList:
//
//var lists = [familyList, workList, inboxList, shoppingList, personalList]

class TaskTypeTableViewCell: UITableViewCell {
    static let identifier = "TaskCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }

    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let margins = UIEdgeInsets(top: 0, left: 2.5, bottom: 5, right: 2.5)
        contentView.frame = contentView.frame.inset(by: margins)
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
