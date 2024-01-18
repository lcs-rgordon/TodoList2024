//
//  TodoListView.swift
//  TodoList2024
//
//  Created by Russell Gordon on 2024-01-17.
//

import SwiftData
import SwiftUI

struct TodoListView: View {
    
    enum InputControls {
        case todoItemEntry
        case todoItemCreation
    }
    
    // MARK: Stored properties
    
    // The item currently being created
    @State private var newItemDetails = ""
    
    // Access the model context (required to do additions, deletions, updates, et cetera)
    @Environment(\.modelContext) private var modelContext
    
    // Fetch all items to show into memory
    @Query private var items: [TodoItem]
    
    // Keeps track of what has the focus
    @FocusState private var currentControl: InputControls?
    
    // MARK: Computed properties
    var body: some View {
        NavigationStack {
            VStack {
                
                HStack {
                    
                    TextField("Enter a to-do item", text: $newItemDetails)
                        .focused($currentControl, equals: .todoItemEntry)
                        .onKeyPress(.return) {
                            addItem()
                            return .handled
                        }
                    
                    Button("Add") {
                        addItem()
                    }
                    .focusable()
                    .focused($currentControl, equals: .todoItemCreation)
                    
                    
                }
                .padding(20)
                
                if items.isEmpty {
                    ContentUnavailableView(label: {
                        Label("You're all caught up!", systemImage: "checkmark")
                            .foregroundStyle(.green)
                    }, description: {
                        Text("To-do items will appear here once you add some.")
                    })
                } else {
                    
                    List {
                        ForEach(items) { currentItem in
                            Label {
                                Text(currentItem.details)
                            } icon: {
                                Image(systemName: currentItem.isCompleted ? "checkmark.circle" : "circle")
                                    .onTapGesture {
                                        toggle(item: currentItem)
                                    }
                            }
                        }
                        .onDelete(perform: delete)
                    }
                }
                
            }
            .navigationTitle("To do")
            // Both seem to be necessary to get the input field to take focus
            .onAppear {
                currentControl = .todoItemEntry
            }
            .task {
                currentControl = .todoItemEntry
            }
        }
    }
    
    // MARK: Functions
    func addItem() {
        let newToDoItem = TodoItem(details: newItemDetails)
        modelContext.insert(newToDoItem)
        newItemDetails = ""
    }
    
    func toggle(item: TodoItem) {
        if item.isCompleted {
            item.completedOn = nil
            item.isCompleted = false
        } else {
            item.completedOn = Date()
            item.isCompleted = true
        }
        
    }
    
    func delete(at offsets: IndexSet) {
        for offset in offsets {
            modelContext.delete(items[offset])
        }
    }
 
}

#Preview {
    LandingView()
}
