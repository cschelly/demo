//
//  ContentViewSheet.swift
//  CoffeeShop
//
//  Created by Christina S on 8/6/20.
//

import SwiftUI

struct CoffeeContentView: View {
    @State private var showPrivacyPreferences = false
    var body: some View {
        TabView {
            CoffeeMenuView()
                .tabItem {
                    Image(systemName: "list.dash")
                    Text("Menu")
                }
            StoreLocatorView()
                .tabItem {
                    Image(systemName: "mappin.and.ellipse")
                    Text("Stores")
                }
            CartView()
                .tabItem {
                    Image(systemName: "cart.fill")
                    Text("Cart")
                }
            SettingsView()
                .tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
            }
        }
        .accentColor(.lightTeal)
    }
}

struct CoffeeContentView_Previews: PreviewProvider {
    static var previews: some View {
        CoffeeContentView()
    }
}
