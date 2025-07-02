//
//  SmartLibraryApp.swift
//  SmartLibrary
//
//  Created by Ambarish Shivakumar on 02/07/25.
//

import SwiftUI

@main
struct SmartLibraryApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
