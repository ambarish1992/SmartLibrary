//
//  Recipe.swift
//  SmartLibrary
//
//  Created by Ambarish Shivakumar on 02/07/25.
//

import Foundation

struct Recipe: Identifiable, Codable, Equatable {
    let id: UUID
    var title: String
    var ingredients: String
    var instructions: String
    var imageData: Data?
    
    init(id: UUID = UUID(), title: String, ingredients: String, instructions: String, imageData: Data? = nil) {
        self.id = id
        self.title = title
        self.ingredients = ingredients
        self.instructions = instructions
        self.imageData = imageData
    }
}
