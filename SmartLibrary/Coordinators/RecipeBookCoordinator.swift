//
//  RecipeBookCoordinator.swift
//  SmartLibrary
//
//  Created by Ambarish Shivakumar on 02/07/25.
//

import Foundation
import SwiftUI

struct RecipeBookCoordinator: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        TabView {
            RecipeListView()
                .tabItem { Label("Recipes", systemImage: "list.bullet.rectangle") }
            
            MealPlannerView()
                .tabItem { Label("Planner", systemImage: "calendar") }
            
            ShoppingListView()
                .tabItem { Label("Shopping", systemImage: "cart") }
            
            RecipeSettingsView()
                .tabItem { Label("Settings", systemImage: "gear") }
        }
        .accentColor(Color("RecipeThemeColor"))
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Switch Module") {
                    appState.selectedModule = .none
                }
            }
        }
    }
}

