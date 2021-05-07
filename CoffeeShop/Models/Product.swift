//
//  Product.swift
//  CoffeeShop
//
//  Created by Christina on 5/6/21.
//

import Foundation

struct Product: Codable, Identifiable {
    var id: String
    var name: String
    var image: String
    var price: String
}

struct CoffeeMenu {
    static var items = Bundle.main.decode([Product].self, from: "products.json")
}
