//
//  TodoItem.swift
//  TodoList2024
//
//  Created by Russell Gordon on 2024-01-17.
//

import Foundation

class TodoItem {
    var details: String
    let createdOn: Date
    var isCompleted: Bool
    var completedOn: Date?

    // Must provide the details for a to-do item.
    // createdOn will default to current date/time.
    // isCompleted defaults to false.
    // We don't know when the to-do item will be completed, so it is nil.
    init(
        details: String,
        createdOn: Date = Date(),
        isCompleted: Bool = false,
        completedOn: Date?
    ) {
        self.details = details
        self.createdOn = createdOn
        self.isCompleted = isCompleted
        self.completedOn = completedOn
    }
}
