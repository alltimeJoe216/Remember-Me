//
//  TaskRepresentation.swift
//  RememberMe
//
//  Created by Joe Veverka on 7/12/20.
//  Copyright © 2020 Joe Veverka. All rights reserved.
//

import Foundation

struct TaskRepresentation: Codable {
    let title: String
    let identifier: String
    let taskType: String
    let timeStamp: Date
    let complete: Bool
}
