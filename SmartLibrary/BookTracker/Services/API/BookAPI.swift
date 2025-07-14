//
//  BookAPI.swift
//  SmartLibrary
//
//  Created by Ambarish Shivakumar on 09/07/25.
//
import Foundation

enum APIEndpoint {
    case books
    
    var url: URL? {
        switch self {
        case .books:
            return URL(string: "https://gutendex.com/books")
        }
    }
}
