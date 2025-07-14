//
//  RecipeRowView.swift
//  SmartLibrary
//
//  Created by Ambarish Shivakumar on 14/07/25.
//

import SwiftUI

struct RecipeGridItem: View {
    let video: YouTubeVideoItem
    
    var body: some View {
        VStack(spacing: 6) {
            if let url = video.thumbnailURL {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 160, height: 100)
                        .clipped()
                        .cornerRadius(8)
                } placeholder: {
                    Color.gray
                        .frame(width: 160, height: 100)
                        .cornerRadius(8)
                }
            }
            
            Text(video.snippet.title)
                .font(.caption)
                .fontWeight(.semibold)
                .lineLimit(2)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity)
        }
        .frame(width: 160)
    }
}

#Preview {
    RecipeGridItem(video: YouTubeVideoItem(
        snippet: YouTubeVideoItem.Snippet(
            title: "Paneer Butter Masala by Hebbar’s Kitchen",
            description: "Delicious restaurant-style paneer butter masala recipe.",
            channelTitle: "Hebbar’s Kitchen",
            thumbnails: YouTubeVideoItem.Snippet.Thumbnails(
                medium: .init(url: "https://img.youtube.com/vi/abc123/mqdefault.jpg")
            ),
            resourceId: .init(videoId: "abc123")
        ),
        videoId: nil
    ))
}
