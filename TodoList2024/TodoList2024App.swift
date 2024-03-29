//
//  TodoList2024App.swift
//  TodoList2024
//
//  Created by Russell Gordon on 2024-01-17.
//

import SwiftData
import SwiftUI

@main
struct TodoList2024App: App {
    var body: some Scene {
        WindowGroup {
            LandingView()
                .modelContainer(for: TodoItem.self)
        }
    }
}
