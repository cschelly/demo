//
//  ConsentPreferences.swift
//  CoffeeShop
//
//  Created by Christina S on 8/6/20.
//

import SwiftUI

class Consent: ObservableObject {
    @Published var categories = ConsentCategories.default
    
    init(categoriesFromStorage: ConsentCategories? = nil) {
        categories = categoriesFromStorage ?? ConsentCategories.default
    }
}
struct ConsentCategory: Codable, Hashable {
    var name: String
    var description: String
    var status: Bool
    var expanded: Bool
}
typealias ConsentCategories = [ConsentCategory]
extension ConsentCategories {
    static var `default` = [ConsentCategory(name: "Analytics",
                                             description: "The measurement, collection, analysis and reporting of mobile data.",
                                             status: false,
                                             expanded:  false),
                            ConsentCategory(name: "Email",
                                             description: "To track when visitors are entering our site to determine effectiveness of our targeting efforts.",
                                             status: false,
                                             expanded:  false),
                            ConsentCategory(name: "Personalization",
                                             description: "To create customized experiences for visitors to our mobile app.",
                                             status: false,
                                             expanded:  false),
                            ConsentCategory(name: "Social",
                                             description: "To better generate, target, and deliver marketing communications via Social networks.",
                                             status: false,
                                             expanded:  false),
                            ConsentCategory(name: "CDP",
                                             description: "To create a persistent, unified customer database that is accessible to all of our systems.",
                                             status: false,
                                             expanded:  false),
                            ConsentCategory(name: "CRM",
                                             description: "Tools that allow us to manage your customer/account information cross device.",
                                             status: false,
                                             expanded:  false),
                            ConsentCategory(name: "Misc",
                                                                                description: "Functionality important to delivery an optimal mobile experience.",
                                                                                status: false,
                                                                                expanded: false),]
}
