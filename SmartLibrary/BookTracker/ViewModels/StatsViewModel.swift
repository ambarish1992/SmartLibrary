//
//  StatsViewModel.swift
//  SmartLibrary
//
//  Created by Ambarish Shivakumar on 12/07/25.
//

import Foundation

final class StatsViewModel: ObservableObject {
    
    @Published var stockStats: [StockStat] = []
    @Published var genreStats: [ReadingStat] = []
    @Published var monthlyStats: [MonthlyReading] = []
    @Published var cumulativeStats: [CumulativeReading] = []
    
    init() {
        loadMockData()
    }
    
    private func loadMockData() {
        genreStats = [
            ReadingStat(category: "Fiction", count: 40),
            ReadingStat(category: "Non-Fiction", count: 20),
            ReadingStat(category: "Sci-Fi", count: 15),
            ReadingStat(category: "Romance", count: 25)
        ]
        
        monthlyStats = [
            MonthlyReading(month: "Jan", booksRead: 5),
            MonthlyReading(month: "Feb", booksRead: 7),
            MonthlyReading(month: "Mar", booksRead: 3),
            MonthlyReading(month: "Apr", booksRead: 8)
        ]
        
        cumulativeStats = [
            CumulativeReading(day: 1, total: 1),
            CumulativeReading(day: 2, total: 3),
            CumulativeReading(day: 3, total: 5),
            CumulativeReading(day: 4, total: 8),
            CumulativeReading(day: 5, total: 13)
            

        ]
        
        stockStats = [
            StockStat(day: "Mon", high: 12, low: 5, close: 9),
            StockStat(day: "Tue", high: 15, low: 8, close: 10),
            StockStat(day: "Wed", high: 18, low: 12, close: 16),
            StockStat(day: "Thu", high: 14, low: 10, close: 11),
            StockStat(day: "Fri", high: 20, low: 13, close: 19)
        ]
    }
}
