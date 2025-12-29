//
//  SettingsView.swift
//  SwiftUI-template
//
//  Created by Adrian Neshad on 2025-12-28.
//

import SwiftUI
import AlertToast
import MessageUI
/* import StoreKit */

struct SettingsView: View {
    
    /* @StateObject private var storeManager = StoreManager() */
    
    @AppStorage("darkMode") private var darkMode = true
    @AppStorage("appLanguage") private var appLanguage = "en"
    @AppStorage("iAP-ID") private var inAppUnlocked = false
    
    @State private var showRestoreAlert = false
    @State private var showPurchaseSheet = false
    @State private var restoreStatus: RestoreStatus?
    @State private var showMailFeedback = false
    @State private var mailErrorAlert = false
    @State private var showClearAlert = false
    @State private var showToast = false
    @State private var toastMessage = ""
    @State private var showShareSheet = false
    @State private var showAppIconSelector = false
    
    enum RestoreStatus {
        case success, failure
    }

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text(StringManager.shared.get("general"))) {
                    Toggle(StringManager.shared.get("darkmode"), isOn: $darkMode)
                        .toggleStyle(SwitchToggleStyle(tint: .blue))
                    
                    Picker(StringManager.shared.get("language"), selection: $appLanguage) {
                        
                        Text("🇺🇸 English").tag("en")       // English
                        Text("🇸🇪 Svenska").tag("sv")       // Svenska
                        
                    }
                    .pickerStyle(MenuPickerStyle())
                    
                    Button(action: {
                        showAppIconSelector = true
                    }) {
                        HStack {
                            Label {
                                Text(StringManager.shared.get("chooseappicon"))
                                    .foregroundColor(.blue)
                            } icon: {
                                Image(systemName: "app.dashed")
                                    .foregroundColor(.blue)
                            }
                            Spacer()
                            Image(systemName: "chevron.right")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            }
                    }
                    .sheet(isPresented: $showAppIconSelector) {
                        AppIconSelector()
                    }
                }
                
                /*
                 // Buy-section
                 Section(header: Text(StringManager.shared.get("inAppUnlocked"))) {
                 if !inAppUnlocked {
                 Button(action: {
                 showPurchaseSheet = true
                 }) {
                 HStack {
                 Image(systemName: "lock.open")
                 Text(StringManager.shared.get("unlockInApp"))
                 Spacer()
                 if let product = storeManager.products.first {
                 Text(product.localizedPrice)
                 .foregroundColor(.gray)
                 }
                 }
                 }
                 .sheet(isPresented: $showPurchaseSheet) {
                 PurchaseView(storeManager: storeManager, isUnlocked: $inAppUnlocked)
                 }
                 } else {
                 HStack {
                 Image(systemName: "checkmark.seal.fill")
                 .foregroundColor(.green)
                 Text(StringManager.shared.get("inAppUnlocked"))
                 .foregroundColor(.green)
                 }
                 }
                 
                 Button(StringManager.shared.get("restorepurchase")) {
                 storeManager.restorePurchases()
                 showRestoreAlert = true
                 }
                 .alert(isPresented: $showRestoreAlert) {
                 switch restoreStatus {
                 case .success:
                 return Alert(
                 title: Text(StringManager.shared.get("purchaserestored")),
                 message: Text(StringManager.shared.get("purchaserestored")),
                 dismissButton: .default(Text("OK")))
                 case .failure:
                 return Alert(
                 title: Text(StringManager.shared.get("restorefailed")),
                 message: Text(StringManager.shared.get("purchasecouldntrestore")),
                 dismissButton: .default(Text("OK")))
                 default:
                 return Alert(
                 title: Text(StringManager.shared.get("processing...")),
                 message: nil,
                 dismissButton: .cancel())
                 }
                 }
                 .onReceive(storeManager.$transactionState) { state in
                 if state == .restored {
                 restoreStatus = .success
                 inAppUnlocked = true
                 } else if state == .failed {
                 restoreStatus = .failure
                 }
                 }
                 }
                 */
                
                Section(header: Text(StringManager.shared.get("about"))) {
                    Button(action: {
                        if let url = URL(string: "https://apps.apple.com/app/id6745692591?action=write-review") {
                            UIApplication.shared.open(url)
                        }
                    }) {
                        Label(StringManager.shared.get("ratetheapp"), systemImage: "star")
                    }
                    Button(action: {
                        showShareSheet = true
                    }) {
                        Label(StringManager.shared.get("sharetheapp"), systemImage: "square.and.arrow.up")
                    }
                    .sheet(isPresented: $showShareSheet) {
                        let message = StringManager.shared.get("checkoutunivert")
                        let appLink = URL(string: "https://apps.apple.com/us/app/univert/id6745692591")!
                        ShareSheet(activityItems: [message, appLink])
                            .presentationDetents([.medium])
                    }
                    Button(action: {
                        if MFMailComposeViewController.canSendMail() {
                            showMailFeedback = true
                        } else {
                            mailErrorAlert = true
                        }
                    }) {
                        Label(StringManager.shared.get("givefeedback"), systemImage: "envelope")
                    }
                    .sheet(isPresented: $showMailFeedback) {
                        MailFeedback(isShowing: $showMailFeedback,
                                     recipientEmail: "Adrian.neshad1@gmail.com",
                                     subject: StringManager.shared.get("univertfeedback"),
                                     messageBody: "")
                    }
                }
                
                Section(header: Text(StringManager.shared.get("otherapps"))) {
                    Link(destination: URL(string: "https://apps.apple.com/us/app/univert/id6745692591")!) {
                        HStack {
                            Image("univert")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .cornerRadius(8)
                            Text("Univert - Unit Converter")
                        }
                    }
                    Link(destination: URL(string: "https://apps.apple.com/us/app/unifeed-nyhetsfl%C3%B6de/id6746872036")!) {
                        HStack {
                            Image("unifeed")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .cornerRadius(8)
                            Text("Unifeed - Newsfeed")
                        }
                    }
                    Link(destination: URL(string: "https://apps.apple.com/us/app/flixswipe-explore-new-movies/id6746716902")!) {
                        HStack {
                            Image("flixswipe")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .cornerRadius(8)
                            Text("SwipeFlix - Explore New Movies")
                        }
                    }
                }
                
                Section {
                    Text(appVersion)
                }
                
                Section {
                    EmptyView()
                } footer: {
                    AppFooter()
                }
            }
            .navigationTitle(StringManager.shared.get("settings"))
            .toolbarTitleDisplayMode(.inlineLarge)
            
            /*
             .onAppear {
             storeManager.getProducts(productIDs: ["iAP-ID"])
             }
             .toast(isPresenting: $showToast) {
             AlertToast(type: .complete(Color.green), title: toastMessage)
             }
             */
        }
    }
    
    private var appVersion: String {
        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "?"
        let build = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "?"
        return "Version \(version) (\(build))"
    }
}
