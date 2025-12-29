//
//  lang.swift
//  SwiftUI-template
//
//  Created by Adrian Neshad on 2025-12-28.
//

import SwiftUI

class StringManager {
    static let shared = StringManager()
    @AppStorage("appLanguage") var language: String = "en"
    
    private let en: [String: String] = [
        "close": "Close",
        "home": "Home",
        "feed": "Feed",
        "settings": "Settings",
        "language": "Language",
        "darkmode": "Dark Mode",
        "general": "General",
        "about": "About",
        "rate": "Rate",
        "shareapp": "Share app",
        "checkin": "Check in",
        "givefeedback": "Give feedback",
        "otherapps": "Other apps",
        "search": "Search",
        "ratetheapp": "Rate the App",
        "sharetheapp": "Share the App",
        "chooseappicon": "Choose App Icon",
        "favorites": "Favorites",
        "notaddedfavorites": "You haven't added any favorites yet",
        
    ]

    private let sv: [String: String] = [
        "close": "Stäng",
        "home": "Hem",
        "feed": "Flöde",
        "settings": "Inställningar",
        "language": "Språk",
        "darkmode": "Mörkt läge",
        "general": "Allmänt",
        "about": "Om",
        "rate": "Betygsätt",
        "shareapp": "Dela appen",
        "checkin": "Kolla in",
        "givefeedback": "Ge feedback",
        "otherapps": "Andra appar",
        "search": "Sök",
        "ratetheapp": "Betygsätt appen",
        "sharetheapp": "Dela appen",
        "chooseappicon": "Välj appikon",
        "favorites": "Favoriter",
        "notaddedfavorites": "Du har inte lagt till några favoriter än",
        
    ]
    
    private var tables: [String: [String: String]] {
        [
            "sv": sv, // Svenska
            "en": en, // Engelska
        ]
    }

    func get(_ key: String) -> String {
        tables[language]?[key] ?? key
    }
}
