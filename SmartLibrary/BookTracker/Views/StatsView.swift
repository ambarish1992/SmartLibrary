//
//  StatsView.swift
//  SmartLibrary
//
//  Created by Ambarish Shivakumar on 02/07/25.
//

import SwiftUI
import Charts

struct StatsView: View {
    @StateObject private var viewModel = StatsViewModel()
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                Text("Book Stats")
                    .font(.largeTitle.bold())
                    .padding(.horizontal)
                
                // Pie Chart
                Chart(viewModel.genreStats) { stat in
                    SectorMark(
                        angle: .value("Books", stat.count),
                        innerRadius: .ratio(0.5),
                        angularInset: 1
                    )
                    .foregroundStyle(by: .value("Genre", stat.category))
                }
                .frame(height: 250)
                .padding()
                
                // Bar Chart
                Text("Monthly Reading")
                    .font(.title2.bold())
                    .padding(.horizontal)
                
                Chart(viewModel.monthlyStats) { stat in
                    BarMark(
                        x: .value("Month", stat.month),
                        y: .value("Books", stat.booksRead)
                    )
                    .foregroundStyle(.blue)
                }
                .frame(height: 200)
                .padding()
                
                Text("Stock-like Book Activity")
                    .font(.title2.bold())
                    .padding(.horizontal)
                
                Chart {
                    ForEach(viewModel.stockStats) { stat in
                        LineMark(
                            x: .value("Day", stat.day),
                            y: .value("Close", stat.close)
                        )
                        .foregroundStyle(.green)
                        .interpolationMethod(.catmullRom)
                        
                        AreaMark(
                            x: .value("Day", stat.day),
                            yStart: .value("Low", stat.low),
                            yEnd: .value("High", stat.high)
                        )
                        .foregroundStyle(.linearGradient(colors: [.blue.opacity(0.4), .blue.opacity(0.1)], startPoint: .top, endPoint: .bottom))
                    }
                }
                .frame(height: 250)
                .padding()

                
                // Line Chart
                Text("Reading Progress")
                    .font(.title2.bold())
                    .padding(.horizontal)
                
                Chart(viewModel.cumulativeStats) { point in
                    LineMark(
                        x: .value("Day", point.day),
                        y: .value("Total Read", point.total)
                    )
                    .interpolationMethod(.catmullRom)
                }
                .frame(height: 200)
                .padding()
            }
        }
    }
}


#Preview {
    StatsView()
}
