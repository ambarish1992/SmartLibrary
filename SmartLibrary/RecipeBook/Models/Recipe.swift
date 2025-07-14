//
//  Recipe.swift
//  SmartLibrary
//
//  Created by Ambarish Shivakumar on 02/07/25.
//

import Foundation

struct YouTubeVideoResponse: Codable {
    let items: [YouTubeVideoItem]
}

struct YouTubeVideoItem: Codable, Identifiable {
    var id: String { snippet.resourceId?.videoId ?? videoId ?? UUID().uuidString }
    
    let snippet: Snippet
    let videoId: String?
    
    struct Snippet: Codable {
        let title: String
        let description: String
        let channelTitle: String
        let thumbnails: Thumbnails
        let resourceId: ResourceId?
        
        struct Thumbnails: Codable {
            let medium: Thumbnail
            
            struct Thumbnail: Codable {
                let url: String
            }
        }
        
        struct ResourceId: Codable {
            let videoId: String
        }
    }
    
    var videoURL: URL? {
        if let id = snippet.resourceId?.videoId ?? videoId {
            return URL(string: "https://www.youtube.com/embed/\(id)")
        }
        return nil
    }
    
    var thumbnailURL: URL? {
        URL(string: snippet.thumbnails.medium.url)
    }
}

