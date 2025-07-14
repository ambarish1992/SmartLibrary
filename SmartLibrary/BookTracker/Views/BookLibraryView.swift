//
//  BookLibraryView.swift
//  SmartLibrary
//
//  Created by Ambarish Shivakumar on 02/07/25.
//
import SwiftUI

import SwiftUI

struct BookLibraryView: View {
    @StateObject private var viewModel = BookTrackerViewModel()
    private let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        NavigationView {
            ZStack {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(viewModel.books, id: \.id) { book in
                            if let url = book.htmlURL {
                                NavigationLink(destination: PDFViewerScreen(htmlURL: url)) {
                                    BookGridItem(book: book)
                                }
                            } else {
                                BookGridItem(book: book)
                            }
                        }
                    }
                    .padding()
                }
                
                if viewModel.isLoading && viewModel.books.isEmpty {
                    Color(.systemBackground)
                        .opacity(0.8)
                        .ignoresSafeArea()
                    
                    ProgressView("Loading Books...")
                        .progressViewStyle(CircularProgressViewStyle())
                        .scaleEffect(1.5)
                }
            }
            .navigationTitle("Library")
            .onAppear {
                viewModel.fetchBooks()
            }
        }
    }
}

struct BookGridItem: View {
    let book: Book
    
    var body: some View {
        GeometryReader { geo in
            VStack(spacing: 4) {
                if let imageURL = book.coverImageURL {
                    AsyncImage(url: imageURL) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: geo.size.width, height: geo.size.width)
                            .clipped()
                            .cornerRadius(8)
                    } placeholder: {
                        ProgressView()
                            .frame(width: geo.size.width, height: geo.size.width)
                    }
                } else {
                    Rectangle()
                        .fill(Color.gray.opacity(0.2))
                        .frame(width: geo.size.width, height: geo.size.width)
                        .cornerRadius(8)
                }
                
                VStack(spacing: 2) {
                    Text(book.title)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .lineLimit(2)
                        .multilineTextAlignment(.center)
                    
                    Text(book.authorNames)
                        .font(.caption2)
                        .foregroundColor(.secondary)
                        .lineLimit(1)
                }
                .padding(.horizontal, 4)
            }
        }
        .frame(height: 200) // ensures square grid cells
    }
}


#Preview {
    BookLibraryView()
}
