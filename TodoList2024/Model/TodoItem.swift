//
//  TodoItem.swift
//  TodoList2024
//
//  Created by Russell Gordon on 2024-01-17.
//

import Foundation
import SwiftData

// Enum must be set Codable to be stored in SwiftData
enum Completed: String, Codable {
    case yes = "yes"
    case no = "no"
}

@Model
class TodoItem: Identifiable {

    var details: String
    let createdOn: Date
    var isCompleted: Completed
    var completedOn: Date?

    // Must provide the details for a to-do item.
    // createdOn will default to current date/time.
    // isCompleted defaults to false.
    // We don't know when the to-do item will be completed, so it is nil.
    init(
        details: String,
        createdOn: Date = Date(),
        isCompleted: Completed = .no,
        completedOn: Date? = nil
    ) {
        self.details = details
        self.createdOn = createdOn
        self.isCompleted = isCompleted
        self.completedOn = completedOn
    }
}

extension TodoItem {
    
    @MainActor
    static var preview: ModelContainer {
        
        let container = try! ModelContainer(
            for: TodoItem.self,
            configurations: ModelConfiguration(isStoredInMemoryOnly: true)
        )
        
        // Add mock data
        container.mainContext.insert(TodoItem(details: "Go for a swim", isCompleted: .no))
        container.mainContext.insert(TodoItem(details: "Have a nap", isCompleted: .yes))
        container.mainContext.insert(TodoItem(details: "Study for Physics", isCompleted: .no))

        return container
    }
    
    @MainActor
    static var emptyListPreview: ModelContainer {
        
        let container = try! ModelContainer(
            for: TodoItem.self,
            configurations: ModelConfiguration(isStoredInMemoryOnly: true)
        )
        
        // No data

        // Return empty container
        return container
    }

    
}
