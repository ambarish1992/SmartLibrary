//
//  RecipeListView.swift
//  SmartLibrary
//
//  Created by Ambarish Shivakumar on 02/07/25.
//

import SwiftUI

struct RecipeListView: View {
    @StateObject private var viewModel = RecipeListViewModel()
    private let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        NavigationView {
            ScrollView {
                if viewModel.isLoading {
                    ProgressView("Loading...")
                        .padding()
                } else if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                        .padding()
                } else {
                    VStack(alignment: .leading, spacing: 24) {
                        if !viewModel.hebbarsVideos.isEmpty {
                            RecipeSectionView(title: "Hebbar’s Kitchen", videos: viewModel.hebbarsVideos)
                        }
                        if !viewModel.yourFoodLabVideos.isEmpty {
                            RecipeSectionView(title: "Your Food Lab", videos: viewModel.yourFoodLabVideos)
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Recipes")
            .onAppear {
                viewModel.fetchAllVideos()
            }
        }
    }
}

struct RecipeSectionView: View {
    let title: String
    let videos: [YouTubeVideoItem]
    
    private let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.headline)
            
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(videos) { video in
                    NavigationLink(destination: RecipeDetailView(video: video)) {
                        RecipeGridItem(video: video)
                    }
                }
            }
        }
    }
}

#Preview {
    RecipeListView()
}
