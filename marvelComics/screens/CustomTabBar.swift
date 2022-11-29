//
//  CustomTabBar.swift
//  marvelComics
//
//  Created by Abduqaxxor on 24/11/22.
//

import SwiftUI

struct CustomTabBar: View {
    
    @Binding var currentTab: String
    var bottomEdge: CGFloat
    
    var body: some View {
            HStack(spacing: 0) {
                ForEach(["square.grid.2x2.fill", "gearshape.fill"] , id: \.self) { image in
                    TabButton(image: image, currentTab: $currentTab)
                }
            }
        .padding(.top , 15)
        .padding(.bottom,bottomEdge)
        .background(.thinMaterial)
    }
}

struct CustomTabBar_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct TabButton: View {
    
    var image: String
    @Binding var currentTab: String
    
    var body: some View {
        Button {
            withAnimation{ currentTab = image }
        } label: {
            Image(systemName: image)
                .renderingMode(.template)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 30, height: 30)
                .foregroundColor( currentTab == image ? Color.red : Color.gray.opacity(0.7) )
                .frame(maxWidth: .infinity)
        }

    }
}
