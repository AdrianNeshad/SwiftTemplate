//
//  ContentView.swift
//  SwiftUI-template
//
//  Created by Adrian Neshad on 2025-12-28.
//

import SwiftUI

struct IndexView: View {
    
    @AppStorage("darkMode") private var darkMode = true
    @AppStorage("appLanguage") private var appLanguage = "en"
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    Text("Hello World!")
                        .font(.title)
                        // Test banner id: ca-app-pub-3940256099942544/2435281174
                        // Riktigt ID: ca-app-pub-9539709997316775/1417576689
                        LazyBannerAdView(adUnitID: "ca-app-pub-3940256099942544/2435281174")
                }
            }
            .toolbar {
                ToolbarItemGroup {
                    NavigationLink(destination: FavoritesView()) {
                        Image(systemName: "star")
                    }
                }
            }
            .navigationTitle(StringManager.shared.get("home"))
            .toolbarTitleDisplayMode(.inlineLarge)
            .preferredColorScheme(darkMode ? .dark : .light)
        }
    }
}
