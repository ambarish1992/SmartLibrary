//
//  YoutubePlayer.swift
//  SmartLibrary
//
//  Created by Ambarish Shivakumar on 14/07/25.
//

import SwiftUI
import WebKit

struct YouTubePlayerView: UIViewRepresentable {
    let videoID: String
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.scrollView.isScrollEnabled = false
        webView.configuration.allowsInlineMediaPlayback = true
        return webView
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        let embedHTML = """
        <html>
        <head><meta name='viewport' content='initial-scale=1.0, maximum-scale=1.0'></head>
        <body style='margin:0'>
        <iframe width='100%' height='100%' src='https://www.youtube.com/embed/\(videoID)?playsinline=1' frameborder='0' allow='autoplay; encrypted-media' allowfullscreen></iframe>
        </body>
        </html>
        """
        webView.loadHTMLString(embedHTML, baseURL: nil)
    }
}

#Preview {
    YouTubePlayerView(videoID: "")
}
