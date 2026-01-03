//
//  LazyBannerAdView.swift
//  SwiftTemplate
//
//  Created by Adrian Neshad on 2026-01-03.
//

import SwiftUI

struct LazyBannerAdView: View {
    let adUnitID: String
    @State private var isAdLoaded = false
    @State private var adHeight: CGFloat? = nil
    
    var body: some View {
        GeometryReader { geometry in
            Color.clear
                .frame(height: adHeight ?? 0)
                .background(
                    Group {
                            BannerAdView(adUnitID: adUnitID,
                                         isAdLoaded: $isAdLoaded,
                                         adHeight: $adHeight)
                            .frame(height: adHeight ?? 0)
                            .cornerRadius(10)
                    }
                )
        }
        .frame(height: adHeight ?? 0)
        .padding(.top, adHeight != nil ? 8 : 0)
        .padding(.horizontal, adHeight != nil ? 16 : 0)
    }
}
