//
//  AppIconSelector.swift
//  SwiftTemplate
//
//  Created by Adrian Neshad on 2025-12-29.
//

import SwiftUI

enum AppIcon: String, CaseIterable {
    case appIcon = "AppIcon"
    case appIcon2 = "AppIcon2"
    
    var iconValue: String? {
        if self == .appIcon {
            return nil
        } else {
            return rawValue
        }
    }
    
    var previewImage: String {
        switch self {
        case .appIcon: "logo"
        case .appIcon2: "logo2"
        }
    }
}

struct AppIconSelector: View {
    
    @Environment(\.dismiss) var dismiss
    @AppStorage("appLanguage") private var appLanguage = "en"
    @AppStorage("darkMode") private var darkMode = true
    @State private var currentAppIcon: AppIcon = .appIcon
    
    let iconNames: [AppIcon: String] = [
        .appIcon: "Standard",
        .appIcon2: "White",
    ]
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    ForEach(AppIcon.allCases, id: \.rawValue) { icon in
                        HStack(spacing: 15) {
                            Image(icon.previewImage)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 60, height: 60)
                                .clipShape(.rect(cornerRadius: 10))
                            
                            Text(iconNames[icon] ?? icon.rawValue)
                                .fontWeight(.semibold)
                            Spacer(minLength: 0)
                            Image(systemName: currentAppIcon == icon ? "checkmark.circle.fill" : "circle")
                                .font(.title3)
                                .foregroundStyle(.blue)
                        }
                        .contentShape(.rect)
                        .onTapGesture {
                            currentAppIcon = icon
                            UIApplication.shared.setAlternateIconName(icon.iconValue)
                        }
                    }
                }
            }
            .navigationTitle(StringManager.shared.get("chooseappicon"))
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(StringManager.shared.get("close")) {
                        dismiss()
                    }
                }
            }
        }
        .onAppear {
            if let alternativeAppIcon = UIApplication.shared.alternateIconName,
               let appIcon = AppIcon.allCases.first(where: { $0.rawValue == alternativeAppIcon }) {
                currentAppIcon = appIcon
            } else {
                currentAppIcon = .appIcon
            }
        }
    }
}
