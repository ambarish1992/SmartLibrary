//
//  SmartLibraryApp.swift
//  SmartLibrary
//
//  Created by Ambarish Shivakumar on 02/07/25.
//

import Foundation
import SwiftUI

@main
struct SmartLibraryApp: App {
    @StateObject private var appState = AppState()
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(appState)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
