//  BookSettingsView.swift
//  SmartLibrary
//
//  Created by Ambarish Shivakumar on 02/07/25.
//

import SwiftUI

struct BookSettingsView: View {
    @StateObject private var viewModel = SettingsViewModel()
    
    var body: some View {
        Form {
            Section(header: Text("Appearance")) {
                Toggle("Dark Mode", isOn: $viewModel.isDarkMode)
                
                VStack(alignment: .leading) {
                    Text("Font Size: \(Int(viewModel.fontSize))")
                    Slider(value: $viewModel.fontSize, in: 12...24, step: 1)
                }
            }
            
            Section(header: Text("Storage")) {
                Button("Clear Cached PDFs") {
                    viewModel.clearPDFCache()
                }
                .foregroundColor(.red)
            }
            
            Section {
                HStack {
                    Text("App Version")
                    Spacer()
                    Text(viewModel.appVersion)
                        .foregroundColor(.secondary)
                }
            }
        }
        .navigationTitle("Settings")
    }
}

#Preview {
  BookSettingsView()
}
