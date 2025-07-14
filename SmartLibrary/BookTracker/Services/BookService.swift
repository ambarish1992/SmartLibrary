//
//  BookService.swift
//  SmartLibrary
//
//  Created by Ambarish Shivakumar on 02/07/25.
//
import Foundation
import Combine

protocol APIServiceProtocol {
    func fetch<T: Decodable>(endpoint: APIEndpoint) -> AnyPublisher<T, APIError>
}

final class APIService: APIServiceProtocol {
    private let apiKey = "ec8557ae7aed4c6686d92c71005a6f4d" 
    func fetch<T: Decodable>(endpoint: APIEndpoint) -> AnyPublisher<T, APIError> {
        guard let url = endpoint.url else {
            return Fail(error: .invalidURL).eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)
        // NewsAPI requires API key in 'X-Api-Key' header
        request.setValue(apiKey, forHTTPHeaderField: "X-Api-Key")
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error in
                if let decodingError = error as? DecodingError {
                    print("Decoding error: \(decodingError)")
                    return .decodingFailed
                }
                return .unknown(error)
            }
            .eraseToAnyPublisher()
    }
}

