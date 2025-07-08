//
//  SettingsView.swift
//  SmartLibrary
//
//  Created by Ambarish Shivakumar on 02/07/25.
//

import SwiftUI

struct RecipeSettingsView: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Preferences")) {
                    Toggle("Meal Notifications", isOn: .constant(true))
                }
                
                Section {
                    Button(role: .destructive) {
                        appState.selectedModule = .none
                    } label: {
                        Label("Switch to Home", systemImage: "arrow.uturn.backward")
                    }
                }
            }
            .navigationTitle("Settings")
        }
    }
}

#Preview {

    RecipeSettingsView()
}
