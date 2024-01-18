//
//  TodoListView.swift
//  TodoList2024
//
//  Created by Russell Gordon on 2024-01-17.
//

import SwiftUI

struct TodoListView: View {
    
    enum InputFields {
        case todoItem
    }
    
    // MARK: Stored properties
    
    // The item currently being created
    @State private var newItemDetails = ""
    
    // Our list of items to complete
    @State private var items: [TodoItem] = []
    
    // Keeps track of what has the focus
    @FocusState private var inputFields: InputFields?
    
    // MARK: Computed properties
    var body: some View {
        NavigationStack {
            VStack {
                
                HStack {
                    
                    TextField("Enter a to-do item", text: $newItemDetails)
                        .focused($inputFields, equals: .todoItem)
                    
                    Button("Add") {
                        addItem()
                    }
                    
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
            .onAppear {
                inputFields = .todoItem
            }
        }
    }
    
    // MARK: Functions
    func addItem() {
        let newToDoItem = TodoItem(details: newItemDetails)
        items.insert(newToDoItem, at: 0)
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
        items.remove(atOffsets: offsets)
    }
 
}

#Preview {
    LandingView()
}
