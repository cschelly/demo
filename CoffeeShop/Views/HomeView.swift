//
//  HomeView.swift
//  CoffeeShop
//
//  Created by Christina S on 8/6/20.
//

import SwiftUI

struct StoreLocatorView: View {
    var body: some View {
        Text("Store Locator").onAppear {
            MParticleManager.logScreen("store_locator_view")
        }
    }
}

struct CartView: View {
    var body: some View {
        Text("Cart").onAppear {
            MParticleManager.logScreen("cart_view")
        }
    }
}
