//
//  BookTrackerCoordinator.swift
//  SmartLibrary
//
//  Created by Ambarish Shivakumar on 02/07/25.
//

import Foundation
import SwiftUI

struct BookTrackerCoordinator: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        TabView {
            MyReadsView()
                .tabItem { Label("My Reads", systemImage: "book.fill") }
            
            TamilLibraryView()
                .tabItem { Label("Tamil Books", systemImage: "text.book.closed") }
            
            StatsView()
                .tabItem { Label("Stats", systemImage: "chart.bar.xaxis") }
            
            BookSettingsView()
                .tabItem { Label("Settings", systemImage: "gear") }
        }
        .accentColor(Color("BookThemeColor"))
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Switch Module") {
                    appState.selectedModule = .none
                }
            }
        }
    }
}

