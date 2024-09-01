//
//  SettingsView.swift
//  CoffeeShop
//
//  Created by Christina S on 8/18/20.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var consent: Consent
    @AppStorage("consent")
    var consentPreferences: Data = Data()
    @State var username: String = ""
    @State var isPrivate: Bool = true
    @State var notificationsEnabled: Bool = false
    @State private var previewIndex = 0
    @State private var showPrivacyPreferences = false
    @State private var stringCategories = [String]()
    var previewOptions = ["Always", "When Unlocked", "Never"]

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("PROFILE")) {
                    TextField("#goteal", text: $username)
                    Toggle(isOn: $isPrivate) {
                        Text("Private Account")
                    }.toggleStyle(SwitchToggleStyle(tint: .lightTeal))
                }
                
                Section(header: Text("NOTIFICATIONS")) {
                    Toggle(isOn: $notificationsEnabled) {
                        Text("Enabled")
                    }.toggleStyle(SwitchToggleStyle(tint: .lightTeal))
                    Picker(selection: $previewIndex, label: Text("Show Previews")) {
                        ForEach(0 ..< previewOptions.count) {
                            Text(self.previewOptions[$0])
                        }
                    }
                }
                
                Section(header: Text("ABOUT")) {
                    HStack {
                        Text("Version")
                        Spacer()
                        Text("2.2.1")
                    }
                }
                
                Section {
                    Button(action: {
                        self.showPrivacyPreferences.toggle()
                    }) {
                        Label("Privacy Settings", systemImage: "hand.raised.fill")
                            .foregroundColor(.lightTeal)
                    }.sheet(isPresented: $showPrivacyPreferences,
                            onDismiss: {
                                guard let categorySelectionStatus = try? JSONEncoder().encode(consent.categories) else {
                                    return
                                }
                                self.consentPreferences = categorySelectionStatus
                                stringCategories = consent.categories.filter {
                                    $0.status == true
                                }.map(\.name)
                                // Call vendor "consent preferences updated"
                    }) {
                        ConsentModal()
                    }.onAppear {
                        MParticleManager.logScreen("privacy_modal_view")
                    }
                }
            }.onAppear {
                MParticleManager.logScreen("settings_view")
            }
            .navigationBarTitle("Settings")
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
