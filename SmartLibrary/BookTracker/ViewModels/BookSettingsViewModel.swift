//
//  BookSettingsViewModel.swift
//  SmartLibrary
//
//  Created by Ambarish Shivakumar on 14/07/25.
//

import Foundation
import SwiftUI

final class SettingsViewModel: ObservableObject {
    @AppStorage("isDarkMode") var isDarkMode: Bool = false
    @AppStorage("fontSize") var fontSize: Double = 16.0
    
    func clearPDFCache() {
        let fileManager = FileManager.default
        let tempDir = fileManager.temporaryDirectory
        
        do {
            let files = try fileManager.contentsOfDirectory(at: tempDir, includingPropertiesForKeys: nil)
            for file in files where file.pathExtension == "pdf" {
                try fileManager.removeItem(at: file)
            }
        } catch {
            print("Failed to clear PDF cache: \(error.localizedDescription)")
        }
    }
    
    var appVersion: String {
        Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "Unknown"
    }
}
