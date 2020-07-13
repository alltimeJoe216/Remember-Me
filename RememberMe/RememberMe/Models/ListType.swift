//
//  ListType.swift
//  RememberMe
//
//  Created by Joe Veverka on 7/11/20.
//  Copyright © 2020 Joe Veverka. All rights reserved.
//

import Foundation
import UIKit

struct ListType {
    var title: String
    var color: UIColor?
    var tasks: [Task] = []
    
  
}

let familyList: ListType = ListType(title: "Family", color: UIColor(named: "FamilyColor"))
let workList: ListType = ListType(title: "Work", color: UIColor(named: "WorkColor"))
let shoppingList: ListType = ListType(title: "Shopping", color: UIColor(named: "ShoppingColor"))
let personalList: ListType = ListType(title: "Personal", color: UIColor(named: "PersonalColor"))
let inboxList: ListType = ListType(title: "Inbox", color: UIColor(named: "Inboxcolor"))
var lists: [ListType] = [inboxList, familyList, personalList, shoppingList, workList]


