//
//  PinkButtonView.swift
//  AppClipTest
//
//  Created by Christina S on 8/3/20.
//

import SwiftUI

struct PinkButtonView: View {
    var title: String
    var imageName: String?
    var action: () -> Void
    
    init(title: String, imageName: String? = nil, _ action: @escaping () -> Void) {
        self.title = title
        self.imageName = imageName
        self.action = action
    }
    
    var body: some View {
        Button(action: action) {
              HStack{
                Text(title)
                    .font(.headline)
                if let imageName = imageName {
                    Image(systemName: imageName)
                        .font(.headline)
                }
              }
              .padding(15)
            }
            .foregroundColor(Color.lightTeal)
            .background(Color.darkTeal)
            .font(.caption)
            .cornerRadius(8)
        
    }
}

struct PinkButtonView_Previews: PreviewProvider {
    static var previews: some View {
        PinkButtonView(title: "Tester Ooni", imageName: "car") {
            // ...
        }
    }
}
