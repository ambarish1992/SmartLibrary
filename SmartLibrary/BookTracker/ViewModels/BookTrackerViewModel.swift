//
//  BookTrackerViewModel.swift
//  SmartLibrary
//
//  Created by Ambarish Shivakumar on 02/07/25.
//

import Foundation
import SwiftSoup

class TamilBooksViewModel: ObservableObject {
    @Published var books: [Book] = []
    
    func fetchBooks() {
        guard let url = URL(string: "https://www.projectmadurai.org/pmworks.html") else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data, let html = String(data: data, encoding: .utf8) {
                self.parseHTML(html)
            } else {
                print("❌ Error fetching or decoding")
            }
        }.resume()
    }
    
    private func parseHTML(_ html: String) {
        do {
            let doc = try SwiftSoup.parse(html)
            let table = try doc.select("table").first()
            let rows = try table?.select("tr")
            
            var tempBooks: [Book] = []
            
            try rows?.dropFirst().forEach { row in
                let cols = try row.select("td")
                guard cols.count >= 3 else { return }
                
                let title = try cols[1].text()
                let author = try cols[2].text()
                let linkTag = try cols[1].select("a").first()
                let linkHref = try linkTag?.attr("href") ?? ""
                let fullPDFLink = URL(string: "https://www.projectmadurai.org/" + linkHref)
                
                if let link = fullPDFLink {
                    let book = Book(title: title, author: author, pdfLink: link)
                    tempBooks.append(book)
                }
            }
            
            DispatchQueue.main.async {
                self.books = tempBooks
            }
            
        } catch {
            print("❌ HTML parsing error: \(error)")
        }
    }
}

