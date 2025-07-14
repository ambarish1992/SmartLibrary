//
//  RecipeDetailView.swift
//  SmartLibrary
//
//  Created by Ambarish Shivakumar on 14/07/25.
//

import SwiftUI
import WebKit

struct RecipeDetailView: View {
    let video: YouTubeVideoItem
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                if let videoURL = video.videoURL {
                    YouTubeWebView(url: videoURL)
                        .frame(height: 220)
                }
                
                Text(video.snippet.title)
                    .font(.headline)
                    .padding(.horizontal)
                
                Text(video.snippet.description)
                    .font(.body)
                    .padding(.horizontal)
            }
        }
        .navigationTitle("Recipe")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct YouTubeWebView: UIViewRepresentable {
    let url: URL
    
    func makeUIView(context: Context) -> WKWebView {
        WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        uiView.load(request)
    }
}

#Preview {
    RecipeDetailView(video: YouTubeVideoItem(
        snippet: YouTubeVideoItem.Snippet(
            title: "Your Food Lab | Masala Pasta Recipe",
            description: """
                Try out this spicy masala pasta cooked Indian-style with a fusion twist!
                Perfect for brunch or dinner.
                """,
            channelTitle: "Your Food Lab",
            thumbnails: YouTubeVideoItem.Snippet.Thumbnails(
                medium: .init(url: "https://img.youtube.com/vi/def456/mqdefault.jpg")
            ),
            resourceId: .init(videoId: "def456")
        ),
        videoId: nil
    ))
}
