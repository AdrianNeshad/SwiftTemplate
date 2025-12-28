//
//  AppFooter.swift
//  SwiftUI-template
//
//  Created by Adrian Neshad on 2025-12-28.
//

import SwiftUI

struct AppFooter: View {
    var body: some View {
        Section {
            EmptyView()
        } footer: {
            VStack(spacing: 4) {
                Text("© 2026 Template App")
                Text("Github.com/AdrianNeshad")
                Text("Linkedin.com/in/adrian-neshad")
            }
            .font(.caption)
            .foregroundColor(.gray)
            .frame(maxWidth: .infinity, alignment: .center)
        }
    }
}
