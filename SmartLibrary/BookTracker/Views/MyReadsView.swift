//
//  MyReadsView.swift
//  SmartLibrary
//
//  Created by Ambarish Shivakumar on 02/07/25.
//

import SwiftUI
import PDFKit

struct MyReadsView: View {
    @StateObject private var viewModel = TamilBooksViewModel()
    @State private var selectedBook: Book?
    
    var body: some View {
        NavigationStack {
            List(viewModel.books) { book in
                Button(action: {
                    selectedBook = book
                }) {
                    VStack(alignment: .leading) {
                        Text(book.title)
                            .font(.headline)
                        Text(book.author)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
            }
            .navigationTitle("Tamil Books")
            .onAppear {
                viewModel.fetchBooks()
            }
            .sheet(item: $selectedBook) { book in
                PDFViewer(book: book)
            }
        }
    }
}

#Preview {
    MyReadsView()
}
