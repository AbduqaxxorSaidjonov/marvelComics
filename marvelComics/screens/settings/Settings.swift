//
//  Settings.swift
//  marvelComics
//
//  Created by Abduqaxxor on 2/12/22.
//

import SwiftUI

struct Settings: View {
    
    @State var isExpanded = false
    @State var selectedNum = 1
    
    var body: some View {
        VStack(alignment: .center , spacing: 15) {
            Text("Dropdown")
                .font(.largeTitle)
            Text("Number of items")
                .font(.title3)
            DisclosureGroup("\(selectedNum)", isExpanded: $isExpanded) {
                VStack {
                    ForEach(1...5 , id: \.self) {num in
                        Text("\(num)")
                            .font(.title3)
                            .padding(.all , 5)
                            .onTapGesture {
                                self.selectedNum = num
                                withAnimation {
                                    self.isExpanded.toggle()
                                }
                            }
                    }
                }
            }
            .accentColor(.white)
            .font(.title2)
            .foregroundColor(.white)
            .padding(.all)
            .background(.blue)
            .cornerRadius(15)
            
            Spacer()
        }
        .padding(.horizontal , 10)
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
