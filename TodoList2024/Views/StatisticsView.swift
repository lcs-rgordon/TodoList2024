//
//  StatisticsView.swift
//  TodoList2024
//
//  Created by Russell Gordon on 2024-01-17.
//

import Charts
import SwiftData
import SwiftUI

struct StatisticsView: View {
    
    // MARK: Stored properties
    
    // Fetch all items to show into memory
    @Query private var items: [TodoItem]

    // MARK: Computed properties
    
    // Status data
    private var itemCount: (incomplete: Int, complete: Int) {
        
        var completedItems = 0
        for item in items {
            if item.isCompleted == .yes {
                completedItems += 1
            }
        }
        
        return (
            incomplete: items.count - completedItems,
            complete: completedItems
        )
        
    }
    
    // The user interface
    var body: some View {
        NavigationStack {
            Group {
                if items.isEmpty {
                    ContentUnavailableView(label: {
                        Label("No stats available", systemImage: "chart.pie.fill")
                            .foregroundStyle(.green)
                    }, description: {
                        Text("Statistics will appear once you have made and tracked some data.")
                    })
                } else {
                    VStack {
                        
                        HStack {
                            Text("Completion status")
                                .bold()
                            Spacer()
                        }
                        
                        Chart {
                            SectorMark(
                                angle: .value("Item", itemCount.complete),
                                innerRadius: .ratio(0.65),
                                angularInset: 2.0
                            )
                            .foregroundStyle(.green)
                            .annotation(position: .overlay) {
                                Text("\(itemCount.complete)")
                                    .foregroundStyle(.white)
                            }

                            SectorMark(
                                angle: .value("Item", itemCount.incomplete),
                                innerRadius: .ratio(0.65),
                                angularInset: 2.0
                            )
                            .foregroundStyle(.orange)
                            .annotation(position: .overlay) {
                                Text("\(itemCount.incomplete)")
                                    .foregroundStyle(.white)
                            }
                        }
                        .chartBackground { proxy in
                            Text("📝")
                                .font(.system(size: 60))
                        }
                        .padding()
                        
                        HStack {
                            
                            Spacer()
                            
                            Circle()
                                .frame(width: 10)
                                .foregroundStyle(.orange)
                            
                            Text(Completed.no.rawValue)
                                .font(.caption)

                            Spacer()
                            
                            Circle()
                                .frame(width: 10)
                                .foregroundStyle(.green)
                            
                            Text(Completed.yes.rawValue)
                                .font(.caption)
                            
                            Spacer()
                        }
                        
                        Rectangle()
                            .foregroundStyle(.clear)
                            .frame(height: 50)
                        
                    }
                    .padding()
                }
            }
            .navigationTitle("Statistics")
        }

        
    }
}

#Preview {
    LandingView()
        .modelContainer(TodoItem.emptyListPreview)
}
#Preview {
    LandingView()
        .modelContainer(TodoItem.preview)
}
