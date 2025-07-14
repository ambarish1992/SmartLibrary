//
//  PDFViewer.swift
//  SmartLibrary
//
//  Created by Ambarish Shivakumar on 07/07/25.
//
import SwiftUI
import PDFKit
import WebKit

struct PDFViewerScreen: View {
    let htmlURL: URL
    
    @State private var pdfDocument: PDFDocument?
    @State private var isLoading = true
    @State private var currentPage = 1
    @State private var totalPages = 0
    
    var body: some View {
        ZStack {
            if let document = pdfDocument {
                PDFKitView(document: document, currentPage: $currentPage)
                
                VStack {
                    HStack {
                        Spacer()
                        VStack(alignment: .trailing, spacing: 6) {
                            Text("Page \(currentPage) of \(totalPages)")
                                .font(.caption)
                                .foregroundColor(.white)
                                .padding(6)
                                .background(.black.opacity(0.6))
                                .cornerRadius(8)
                            
                            Button("Download") {
                                if let data = document.dataRepresentation(),
                                   let url = savePDFToTemporaryFile(data: data) {
                                    print("Saved to: \(url)")
                                }
                            }
                            .font(.caption)
                            .padding(6)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                        }
                        .padding()
                    }
                    Spacer()
                }
            } else {
                ProgressView("Loading PDF...")
                    .scaleEffect(1.3)
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color(.systemBackground))
            }
        }
        .navigationTitle("PDF Reader")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            loadPDF(from: htmlURL)
        }
    }
    
    private func loadPDF(from url: URL) {
        let webView = WKWebView()
        webView.navigationDelegate = WebViewLoadHandler {
            webView.evaluateJavaScript("document.documentElement.outerHTML.toString()") { result, error in
                guard let html = result as? String else {
                    print("❌ Failed to extract HTML content.")
                    return
                }
                
                let fmt = UIMarkupTextPrintFormatter(markupText: html)
                let pageRect = CGRect(x: 0, y: 0, width: 612, height: 792) // A4
                
                let renderer = UIGraphicsPDFRenderer(bounds: pageRect)
                let pdfData = renderer.pdfData { ctx in
                    for pageIndex in 0..<20 { // max 20 pages
                        ctx.beginPage()
                        fmt.draw(in: ctx.pdfContextBounds, forPageAt: pageIndex)
                    }
                }
                
                DispatchQueue.main.async {
                    if let pdfDoc = PDFDocument(data: pdfData) {
                        self.pdfDocument = pdfDoc
                        self.totalPages = pdfDoc.pageCount
                        self.isLoading = false
                    }
                }
            }
        }
        
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
    private func savePDFToTemporaryFile(data: Data) -> URL? {
        let url = FileManager.default.temporaryDirectory.appendingPathComponent("Book.pdf")
        do {
            try data.write(to: url)
            return url
        } catch {
            print("❌ Failed to save: \(error)")
            return nil
        }
    }
}

struct PDFKitView: UIViewRepresentable {
    let document: PDFDocument
    @Binding var currentPage: Int
    
    func makeUIView(context: Context) -> PDFView {
        let pdfView = PDFView()
        pdfView.document = document
        pdfView.autoScales = true
        pdfView.delegate = context.coordinator
        return pdfView
    }
    
    func updateUIView(_ uiView: PDFView, context: Context) {
        uiView.document = document
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(currentPage: $currentPage)
    }
    
    class Coordinator: NSObject, PDFViewDelegate {
        @Binding var currentPage: Int
        
        init(currentPage: Binding<Int>) {
            _currentPage = currentPage
        }
        
        func pdfViewPageChanged(_ notification: Notification) {
            guard let pdfView = notification.object as? PDFView,
                  let page = pdfView.currentPage,
                  let index = pdfView.document?.index(for: page) else { return }
            currentPage = index + 1
        }
    }
}

class WebViewLoadHandler: NSObject, WKNavigationDelegate {
    let onFinish: () -> Void
    
    init(onFinish: @escaping () -> Void) {
        self.onFinish = onFinish
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.onFinish()
        }
    }
}
