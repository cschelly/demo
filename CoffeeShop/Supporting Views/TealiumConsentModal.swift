//
//  TealiumConsentModal.swift
//  CoffeeShop
//
//  Created by Christina S on 8/18/20.
//

import SwiftUI

struct TealiumConsentModal: View {
    @EnvironmentObject var consent: Consent
    var body: some View {
        NavigationView {
           // ScrollView {
                VStack {
                    Text("The Coffee Shop uses our own technology as well as third-party vendors to help us better understand how you engage with the community so we can build better digital experiences.")
                        .padding()
                    List {
                        ForEach(consent.categories.indices, id: \.self) { index in
                            ConsentRow(category: self.$consent.categories[index])
                        }
                    }
                    .toggleStyle(SwitchToggleStyle(tint: .lightTeal))
                    .navigationTitle("Privacy Settings")
            }
        }
    }
    
}

struct ConsentRow: View {
    @Binding var category: ConsentCategory
    
    var body: some View {
        HStack {
            VStack {
                DisclosureGroup(self.category.name, isExpanded: $category.expanded) {
                    Text(category.description)
                        .font(.system(size: 14))
                        .italic()
                }
                .accentColor(.lightTeal)
                .font(.headline)
            }
            Toggle("", isOn: $category.status)
        }
    }
}

struct TealiumConsentModal_Previews: PreviewProvider {
    static var previews: some View {
        TealiumConsentModal()
    }
}
