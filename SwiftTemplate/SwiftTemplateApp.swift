//
//  SwiftTemplateApp.swift
//  SwiftTemplate
//
//  Created by Adrian Neshad on 2025-12-28.
//

import SwiftUI

@main
struct SwiftTemplateApp: App {
    
    @AppStorage("darkMode") private var darkMode = true
    @AppStorage("appLanguage") private var appLanguage = "en"
    @AppStorage("hasLaunchedBefore") private var hasLaunchedBefore = false
    
    var body: some Scene {
        WindowGroup {
            MainTabView()
                .preferredColorScheme(darkMode ? .dark : .light)
                .onAppear {
                    if !hasLaunchedBefore {
                        setLanguageFromSystem()
                        hasLaunchedBefore = true
                    }
                }
        }
    }
    
    func setLanguageFromSystem() {
        let preferred = Locale.preferredLanguages.first ?? "en"
        let languageCode = preferred.split(separator: "-").first.map(String.init) ?? "en"

        let supportedLanguages: Set<String> = [
            "sv",
        ]

        appLanguage = supportedLanguages.contains(languageCode) ? languageCode : "en"
    }
}
