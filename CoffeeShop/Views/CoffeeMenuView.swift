//
//  CoffeeMenuView.swift
//  CoffeeShop
//
//  Created by Christina S on 8/6/20.
//

import SwiftUI

struct CoffeeMenuView: View {
    var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(CoffeeMenu.items) { item in
                        CoffeeGridItem(item)
                    }
                }
            }
            .navigationTitle("The Coffee Shop")
            .onAppear {
                //let itemList = (ids: CoffeeMenu.items.map(\.id), names: CoffeeMenu.items.map(\.name))
                CoffeeMenu.items.map {
                    MParticleManager.productFrom(id: $0.id, name: $0.name, price: Double($0.price)!)
                }.forEach {
                    MParticleManager.logProductImpression(with: "coffee_menu_view", product: $0)
                }
            }
        }
    }

}

struct CoffeeGridItem: View {
    var item: Product
    
    init(_ item: Product) { self.item = item }
    
    var body: some View {
        VStack {
            Image(item.image)
                .resizable()
                .scaledToFit()
                .padding(.all, 20)
            Text(item.name)
                .bold()
            Text("$\(item.price)")
                .padding(.bottom, 10)
            PinkButtonView(title: "Add To Cart", imageName: "cart.fill") {
                guard let price = Double(item.price) else {
                    return
                }
                let product = MParticleManager.productFrom(id: item.id, name: item.name, price: price)
                MParticleManager.logProductEvent(action: .addToCart, product: product)
            }
        }
    }
    

}

struct CoffeeMenuView_Previews: PreviewProvider {
    static var previews: some View {
        CoffeeMenuView()
    }
}


