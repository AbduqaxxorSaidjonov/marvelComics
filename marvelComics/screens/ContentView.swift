//
//  ContentView.swift
//  marvelComics
//
//  Created by Abduqaxxor on 24/11/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        GeometryReader { proxy in
            
            let bottomEdge = proxy.safeAreaInsets.bottom
            BaseView(bottomEdge: (bottomEdge == 0 ? 15 : bottomEdge))
                .ignoresSafeArea(.all , edges: .bottom)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
