//
//  CoffeeShopApp.swift
//  CoffeeShop
//
//  Created by Christina S on 8/6/20.
//

import SwiftUI

@main
struct CoffeeShopApp: App {
    
    var body: some Scene {
        WindowGroup {
            CoffeeView()
                .onAppear {
                MParticleManager.start()
            }
        }
    }
}

struct CoffeeView: View {
    @AppStorage("consent")
    var consentPreferences: Data = Data()
    var body: some View {
        guard let consentPreferences = try? JSONDecoder().decode(ConsentCategories.self, from: consentPreferences) else {
            return AnyView(CoffeeContentView().environmentObject(Consent()))
        }
        return AnyView(CoffeeContentView().environmentObject(Consent(categoriesFromStorage: consentPreferences)))
    }
}

