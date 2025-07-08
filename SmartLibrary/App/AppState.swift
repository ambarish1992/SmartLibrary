//
//  AppState.swift
//  SmartLibrary
//
//  Created by Ambarish Shivakumar on 02/07/25.
//

import Foundation

import Combine

class AppState: ObservableObject {
    enum ActiveModule {
        case none, bookTracker, recipeBook
    }
    
    @Published var selectedModule: ActiveModule = .none
}

