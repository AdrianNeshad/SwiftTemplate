//
//  BannerAdView.swift
//  SwiftTemplate
//
//  Created by Adrian Neshad on 2026-01-03.
//

import SwiftUI
import GoogleMobileAds
import UIKit

struct BannerAdView: UIViewRepresentable {
    let adUnitID: String
    @Binding var isAdLoaded: Bool
    @Binding var adHeight: CGFloat?
    @State private var adSize: AdSize = AdSize()
    
    func makeUIView(context: Context) -> BannerView {
        let bannerView = BannerView()
        bannerView.adUnitID = adUnitID
        bannerView.delegate = context.coordinator
        
        bannerView.layer.cornerRadius = 10
        bannerView.clipsToBounds = true
        
        configureAdaptiveBanner(bannerView: bannerView)
        bannerView.load(Request())
        
        print("🟡 BannerAdView: Initialize banner with ID: \(adUnitID)")
        
        return bannerView
    }

    func updateUIView(_ uiView: BannerView, context: Context) {
        configureAdaptiveBanner(bannerView: uiView)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(isAdLoaded: $isAdLoaded, adHeight: $adHeight)
    }

    private func configureAdaptiveBanner(bannerView: BannerView) {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first else {
            print("🔴 BannerAdView Error: Couldn't find window for adaptive banner")
            return
        }

        let safeAreaInsets = window.safeAreaInsets
        let horizontalPadding: CGFloat = 32
        let availableWidth = window.frame.width - safeAreaInsets.left - safeAreaInsets.right - horizontalPadding

        let adaptiveSize = currentOrientationAnchoredAdaptiveBanner(width: availableWidth)
        bannerView.adSize = adaptiveSize

        print("🟡 BannerAdView: Configure adaptive banner - Width: \(availableWidth), Height: \(adaptiveSize.size.height)")
    }
}

class Coordinator: NSObject, BannerViewDelegate {
    @Binding var isAdLoaded: Bool
    @Binding var adHeight: CGFloat?

    init(isAdLoaded: Binding<Bool>, adHeight: Binding<CGFloat?>) {
        _isAdLoaded = isAdLoaded
        _adHeight = adHeight
    }

    func bannerViewDidReceiveAd(_ bannerView: BannerView) {
        isAdLoaded = true
        adHeight = bannerView.adSize.size.height
        print("✅ BannerAdView Success: Banner loaded successfully")
        print("📏 BannerAdView: Banner size - Width: \(bannerView.adSize.size.width), Height: \(bannerView.adSize.size.height)")
    }

    func bannerView(_ bannerView: BannerView, didFailToReceiveAdWithError error: Error) {
        isAdLoaded = false
        adHeight = nil
        print("🔴 BannerAdView Error: Failed to load banner")
        print("🔴 Error details: \(error.localizedDescription)")

        if let gadError = error as? RequestError {
            print("🔴 GAD Error Code: \(gadError.code)")
            print("🔴 GAD Error User Info: \(gadError.userInfo)")
        }
    }

    func bannerViewDidRecordImpression(_ bannerView: BannerView) {
        print("📊 BannerAdView: Banner impression registered")
    }

    func bannerViewDidRecordClick(_ bannerView: BannerView) {
        print("👆 BannerAdView: Banner clicked by user")
    }

    func bannerViewWillPresentScreen(_ bannerView: BannerView) {
        print("🟡 BannerAdView: Banner will present fullscreen")
    }

    func bannerViewWillDismissScreen(_ bannerView: BannerView) {
        print("🟡 BannerAdView: Banner will dismiss fullscreen")
    }

    func bannerViewDidDismissScreen(_ bannerView: BannerView) {
        print("✅ BannerAdView: Banner closed fullscreen")
    }
}
