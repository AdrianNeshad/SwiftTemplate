//
//  FavoritesView.swift
//  SwiftTemplate
//
//  Created by Adrian Neshad on 2025-12-29.
//

import SwiftUI

struct FavoritesView: View {
    
    @AppStorage("darkMode") private var darkMode = true
    @AppStorage("appLanguage") private var appLanguage = "en"
        
    var body: some View {
        List {
            VStack(spacing: 10) {
                Image(systemName: "star")
                    .font(.largeTitle)
                    .foregroundColor(.gray)
                Text(StringManager.shared.get("notaddedfavorites"))
                    .font(.body)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.vertical, 50)
        }
        .navigationTitle(StringManager.shared.get("favorites"))
        .navigationBarTitleDisplayMode(.inline)
    }
}
