//
//  MealsAPIService.swift
//  SmartLibrary
//
//  Created by Ambarish Shivakumar on 14/07/25.
//

import Foundation

final class YouTubeAPIService {
    private let apiKey = "AIzaSyBYiYvhPQxAE3-rM1f7_OWP743h8paDeQI"
    
    /// Fetches YouTube videos using a search query string (e.g., "Hebbar's Kitchen")
    func fetchVideos(for query: String, maxResults: Int = 10, completion: @escaping (Result<[YouTubeVideoItem], Error>) -> Void) {
        let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let urlString = "https://www.googleapis.com/youtube/v3/search?part=snippet&q=\(encodedQuery)&type=video&maxResults=\(maxResults)&key=\(apiKey)"
        
        guard let url = URL(string: urlString) else {
            completion(.failure(URLError(.badURL)))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(URLError(.badServerResponse)))
                return
            }
            
            do {
                let response = try JSONDecoder().decode(YouTubeVideoResponse.self, from: data)
                completion(.success(response.items))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
