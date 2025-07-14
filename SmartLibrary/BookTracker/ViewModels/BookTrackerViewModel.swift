//
//  BookTrackerViewModel.swift
//  SmartLibrary
//
//  Created by Ambarish Shivakumar on 02/07/25.
//
import Combine
import SwiftUI

final class BookTrackerViewModel: ObservableObject {
   
    @Published var books: [Book] = []
    @Published var error: APIError?
    @Published var isLoading = false
    
    private var cancellables = Set<AnyCancellable>()
    private let apiService: APIServiceProtocol
    
    // Image cache
    private var imageCache: [URL: UIImage] = [:]
    
    init(apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
    }
    
    func fetchBooks() {
        isLoading = true
        
        apiService.fetch(endpoint: .books)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                guard let self = self else { return }
                self.isLoading = false
                if case let .failure(err) = completion {
                    self.error = err
                }
            }, receiveValue: { [weak self] (response: BookResponse) in
                guard let self = self else { return }
                self.books = response.results
            })
            .store(in: &cancellables)
    }
    
    func cachedImage(for url: URL) -> UIImage? {
        return imageCache[url]
    }
    
    func loadImage(for url: URL, completion: @escaping (UIImage?) -> Void) {
        if let cached = imageCache[url] {
            completion(cached)
            return
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
            guard let data = data, let image = UIImage(data: data) else {
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }
            
            DispatchQueue.main.async {
                self?.imageCache[url] = image
                completion(image)
            }
        }.resume()
    }
}
