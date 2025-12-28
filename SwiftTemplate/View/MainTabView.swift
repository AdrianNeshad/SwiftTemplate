//
//  SwiftUIView.swift
//  SwiftUI-template
//
//  Created by Adrian Neshad on 2025-12-28.
//

import SwiftUI

struct MainTabView: View {
    @State private var selectedTab = 0
    @AppStorage("darkMode") private var darkMode = true
    @AppStorage("appLanguage") private var appLanguage = "en"
    
    var body: some View {
        TabView(selection: $selectedTab) {
            
            Tab(StringManager.shared.get("Home"), systemImage: "newspaper", value: 0) {
                IndexView()
            }
            
            Tab(StringManager.shared.get("settings"), systemImage: "gear", value: 1) {
                SettingsView()
            }
            
        }
    }
}

#Preview {
    MainTabView()
}
