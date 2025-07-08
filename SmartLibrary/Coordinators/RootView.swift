//
//  RootView.swift
//  SmartLibrary
//
//  Created by Ambarish Shivakumar on 02/07/25.
//

import Foundation
import SwiftUI

struct RootView: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        switch appState.selectedModule {
        case .none:
            LaunchView()
        case .bookTracker:
            BookTrackerCoordinator()
        case .recipeBook:
            RecipeBookCoordinator()
        }
    }
}

