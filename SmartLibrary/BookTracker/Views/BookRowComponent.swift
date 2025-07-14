//
//  BookRowComponent.swift
//  SmartLibrary
//
//  Created by Ambarish Shivakumar on 09/07/25.
//
import SwiftUI

//struct BookGridItem: View {
//    let book: Book
//    @ObservedObject var viewModel: BookTrackerViewModel
//    
//    @State private var image: UIImage?
//    
//    var body: some View {
//        VStack {
//            if let url = book.coverImageURL {
//                if let img = image {
//                    Image(uiImage: img)
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
//                        .frame(height: 160)
//                } else {
//                    ProgressView()
//                        .frame(height: 160)
//                        .onAppear {
//                            viewModel.loadImage(for: url) { loadedImage in
//                                image = loadedImage
//                            }
//                        }
//                }
//            }
//            
//            Text(book.title)
//                .font(.caption)
//                .lineLimit(2)
//                .multilineTextAlignment(.center)
//                .padding(.horizontal, 4)
//        }
//        .frame(width: 140)
//        .padding()
//        .background(Color(.secondarySystemBackground))
//        .cornerRadius(10)
//    }
//}

//#Preview {
//    let mockBook = Book(
//        id: 1,
//        title: "Preview Book",
//        authors: [Author(name: "Jane Austen")],
//        formats: Formats(
//            textHTML: "https://www.gutenberg.org/ebooks/1342.html.images",
//            textPlain: "https://www.gutenberg.org/ebooks/1342.txt.utf-8",
//            
//            imageJPEG: "https://www.gutenberg.org/cache/epub/1342/pg1342.cover.medium.jpg", imagePNG: ""
//        )
//    )
//    
//    BookGridItem(book: mockBook)
//        .previewLayout(.sizeThatFits)
//        .padding()
//}
