//
//  Book.swift
//  SmartLibrary
//
//  Created by Ambarish Shivakumar on 02/07/25.
//

import Foundation

struct Book: Identifiable {
    let id = UUID()
    let title: String
    let author: String
    let pdfLink: URL
}

