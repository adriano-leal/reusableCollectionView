//
//  ContentView.swift
//  ReusableCollectionView
//
//  Created by Adriano Ramos on 17/05/20.
//  Copyright © 2020 Adriano Ramos. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var colors: [Color] = [.pink, .red, .orange, .yellow, .green, .blue, .purple, .gray, .black]
    
    
    var body: some View {
        Collection(data: $colors, cols: 2, spacing: 20) { color in
            VStack {
                Spacer()
                Text(color.description)
                    .padding(10)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .background(Color.white)
            }
            .frame(height: 120)
            .background(color)
            .cornerRadius(10)
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black.opacity(0.2), lineWidth: 1))
        }
        .padding()
        .background(Color.black.opacity(0.05).edgesIgnoringSafeArea(.all))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
