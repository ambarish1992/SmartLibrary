//
//  Stats.swift
//  SmartLibrary
//
//  Created by Ambarish Shivakumar on 12/07/25.
//

import Foundation

struct ReadingStat: Identifiable {
    let id = UUID()
    let category: String
    let count: Int
}

struct MonthlyReading: Identifiable {
    let id = UUID()
    let month: String
    let booksRead: Int
}

struct CumulativeReading: Identifiable {
    let id = UUID()
    let day: Int
    let total: Int
}

struct StockStat: Identifiable {
    let id = UUID()
    let day: String
    let high: Double
    let low: Double
    let close: Double
}

