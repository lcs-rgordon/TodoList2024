//
//  LandingView.swift
//  TodoList2024
//
//  Created by Russell Gordon on 2024-01-17.
//

import SwiftUI

struct LandingView: View {
    var body: some View {
        TabView {
            TodoListView()
                .tabItem {
                    Text("Tasks")
                    Image(systemName: "checklist")
                }
            
            StatisticsView()
                .tabItem {
                    Text("Stats")
                    Image(systemName: "chart.line.uptrend.xyaxis")
                }
        }
    }
}

#Preview {
    LandingView()
}
