//
//  APIError.swift
//  SmartLibrary
//
//  Created by Ambarish Shivakumar on 10/07/25.
//
import Foundation
import Combine

enum APIError: Error, LocalizedError {
    case invalidURL
    case decodingFailed
    case unknown(Error)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL."
        case .decodingFailed:
            return "Failed to decode data."
        case .unknown(let error):
            return error.localizedDescription
        }
    }
}
