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
                Text("Hello World!")
                    .font(.title)
            }
            .navigationTitle(StringManager.shared.get("home"))
            .preferredColorScheme(darkMode ? .dark : .light)
        }
    }
}
