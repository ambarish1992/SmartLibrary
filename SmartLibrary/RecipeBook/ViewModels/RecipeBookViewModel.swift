//
//  RecipeBookViewModel.swift
//  SmartLibrary
//
//APIKey = "AIzaSyBYiYvhPQxAE3-rM1f7_OWP743h8paDeQI"
//  Created by Ambarish Shivakumar on 02/07/25.
//

import Foundation
import Combine

final class RecipeListViewModel: ObservableObject {
    @Published var hebbarsVideos: [YouTubeVideoItem] = []
    @Published var yourFoodLabVideos: [YouTubeVideoItem] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let apiService = YouTubeAPIService()
    
    func fetchAllVideos() {
        isLoading = true
        errorMessage = nil
        
        let group = DispatchGroup()
        var fetchedHebbars: [YouTubeVideoItem] = []
        var fetchedYourFoodLab: [YouTubeVideoItem] = []
        
        group.enter()
        apiService.fetchVideos(for: "Hebbar's Kitchen") { result in
            switch result {
            case .success(let videos):
                fetchedHebbars = videos
            case .failure(let error):
                DispatchQueue.main.async {
                    self.errorMessage = "Failed to fetch Hebbar's Kitchen: \(error.localizedDescription)"
                }
            }
            group.leave()
        }
        
        group.enter()
        apiService.fetchVideos(for: "Your Food Lab") { result in
            switch result {
            case .success(let videos):
                fetchedYourFoodLab = videos
            case .failure(let error):
                DispatchQueue.main.async {
                    self.errorMessage = "Failed to fetch Your Food Lab: \(error.localizedDescription)"
                }
            }
            group.leave()
        }
        
        group.notify(queue: .main) {
            self.hebbarsVideos = fetchedHebbars
            self.yourFoodLabVideos = fetchedYourFoodLab
            self.isLoading = false
        }
    }
}

