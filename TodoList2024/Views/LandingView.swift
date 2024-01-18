//
//  LandingView.swift
//  TodoList2024
//
//  Created by Russell Gordon on 2024-01-17.
//

import SwiftUI

struct LandingView: View {
    
    var body: some View {
        TabView(selection: .constant(1)) {
            TodoListView()
                .tabItem {
                    Text("Tasks")
                    Image(systemName: "checklist")
                }
                .tag(1)
            
            StatisticsView()
                .tabItem {
                    Text("Stats")
                    Image(systemName: "chart.line.uptrend.xyaxis")
                }
                .tag(2)
        }
    }
}

#Preview {
    LandingView()
}
