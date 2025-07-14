//
//  Book.swift
//  SmartLibrary
//
//  Created by Ambarish Shivakumar on 02/07/25.
//
import Foundation
import Combine
import SwiftUI

struct BookResponse: Codable {
    let results: [Book]
}

struct Book: Identifiable, Codable, Equatable {
    let id: Int
    let title: String
    let authors: [Author]
    let formats: [String: String] // ✅ dynamic format keys
    
    var authorNames: String {
        authors.map { $0.name }.joined(separator: ", ")
    }
    
    var coverImageURL: URL? {
        if let urlString = formats["image/jpeg"] ?? formats["image/png"] {
            return URL(string: urlString)
        }
        return nil
    }
    
    var htmlURL: URL? {
        if let htmlString = formats["text/html"], htmlString.hasPrefix("http") {
            return URL(string: htmlString)
        }
        return nil
    }
    
    var txtURL: URL? {
        if let txtString = formats["text/plain"], txtString.hasPrefix("http") {
            return URL(string: txtString)
        }
        return nil
    }
}

struct Author: Codable, Equatable {
    let name: String
}

struct Formats: Codable, Equatable {
    let textHTML: String?
    let textPlain: String?
    let imageJPEG: String?
    let imagePNG: String?
}

extension URL: Identifiable {
    public var id: String { absoluteString }
}


