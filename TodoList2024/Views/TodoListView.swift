//
//  TodoListView.swift
//  TodoList2024
//
//  Created by Russell Gordon on 2024-01-17.
//

import SwiftUI

struct TodoListView: View {
    
    // MARK: Stored properties
    
    // The item currently being created
    @State private var newItemDetails = ""
    
    // Our list of items to complete
    @State private var items: [TodoItem] = []
    
    // MARK: Computed properties
    var body: some View {
        NavigationStack {
            VStack {
                
                HStack {
                    
                    TextField("Enter a to-do item", text: $newItemDetails)
                    
                    Button("Add") {
                        addItem()
                    }

                }
                .padding(20)
                
                List(items) { currentItem in
                    Label {
                        Text(currentItem.details)
                    } icon: {
                        Image(systemName: currentItem.isCompleted ? "checkmark.circle" : "circle")
                    }
                }
            }
            .navigationTitle("To do")
        }
    }
    
    // MARK: Functions
    func addItem() {
        let newToDoItem = TodoItem(details: newItemDetails)
        items.insert(newToDoItem, at: 0)
    }
}

#Preview {
    LandingView()
}
