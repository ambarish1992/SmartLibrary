//
//  PlainTextViewer.swift
//  SmartLibrary
//
//  Created by Ambarish Shivakumar on 10/07/25.
//

import Foundation
import SwiftUI

struct PlainTextViewer: View {
    let content: String
    @Binding var isPresented: Bool
    
    var body: some View {
        NavigationView {
            ScrollView {
                Text(content)
                    .padding()
            }
            .navigationTitle("Text Viewer")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close") { isPresented = false }
                }
            }
        }
    }
}

