//
//  LaunchView.swift
//  SmartLibrary
//
//  Created by Ambarish Shivakumar on 03/07/25.
//

import SwiftUI

struct LaunchView: View {

    @EnvironmentObject var appState: AppState
    
    var body: some View {
        ZStack {
            Color("AppBackground").ignoresSafeArea()
            
            VStack(spacing: 32) {
                Text("Welcome! \n To \n Smart Library")
                    .multilineTextAlignment(.center)
                    .font(.title)
                    .fontWeight(.black)
                    .foregroundColor(Color("PrimaryText"))
                
                Button(action: { appState.selectedModule = .bookTracker }) {
                    Label("Go to Book Tracker", systemImage: "book.fill")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color("BookThemeColor"))
                        .foregroundColor(.white)
                        .cornerRadius(12)
                        .padding(.horizontal)
                }
                
                Button(action: { appState.selectedModule = .recipeBook }) {
                    Label("Go to Recipe Book", systemImage: "fork.knife")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color("RecipeThemeColor"))
                        .foregroundColor(.white)
                        .cornerRadius(12)
                        .padding(.horizontal)
                }
            }
        }
    }
}

#Preview {
    LaunchView()
}
