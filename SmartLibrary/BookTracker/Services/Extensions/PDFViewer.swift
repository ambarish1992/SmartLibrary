//
//  PDFViewer.swift
//  SmartLibrary
//
//  Created by Ambarish Shivakumar on 07/07/25.
//

import Foundation
import SwiftUI
import PDFKit

struct PDFViewer: View {
    let book: Book
    
    var body: some View {
        NavigationStack {
            PDFViewWrapper(url: book.pdfLink)
                .navigationTitle(book.title)
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct PDFViewWrapper: UIViewRepresentable {
    let url: URL
    
    func makeUIView(context: Context) -> PDFView {
        let pdfView = PDFView()
        pdfView.autoScales = true
        
        // Load the PDF file
        DispatchQueue.main.async {
            if let data = try? Data(contentsOf: url) {
                pdfView.document = PDFDocument(data: data)
            }
        }
        
        return pdfView
    }
    
    func updateUIView(_ uiView: PDFView, context: Context) {}
}
