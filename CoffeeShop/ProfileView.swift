//
//  SettingsView.swift
//  CoffeeShop
//
//  Created by Christina S on 8/18/20.
//

import SwiftUI

struct SettingsView: View {
    @State var username: String = ""
    @State var isPrivate: Bool = true
    @State var notificationsEnabled: Bool = false
    @State private var previewIndex = 0
    @State private var showPrivacyPreferences = false
    var previewOptions = ["Always", "When Unlocked", "Never"]

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("PROFILE")) {
                    TextField("Username", text: $username)
                    Toggle(isOn: $isPrivate) {
                        Text("Private Account")
                    }
                }
                
                Section(header: Text("NOTIFICATIONS")) {
                    Toggle(isOn: $notificationsEnabled) {
                        Text("Enabled")
                    }
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
                        Label("Privacy Preferences", systemImage: "hand.raised.fill")
                            .foregroundColor(.pink)
                    }.sheet(isPresented: $showPrivacyPreferences) {
                        TealiumConsentModal()
                    }
                }
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
