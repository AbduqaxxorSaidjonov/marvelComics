//
//  HomeScreen.swift
//  marvelComics
//
//  Created by Abduqaxxor on 3/10/22.
//

import SwiftUI

struct BaseView: View {
    
    @State var tabSelection = 0
    
    var body: some View {
        TabView(selection: $tabSelection){
            HomeView(tabSelection: $tabSelection)
                .tabItem{
                VStack{
                    Image(systemName: "square.grid.2x2")
                    Text("Comics")
                }
                }
                .tag(0)
            SettingsView()
                .tabItem {
                    VStack{
                        Image(systemName: "gearshape.fill")
                        Text("Settings")
                    }
                }
                .tag(1)
        }
        .accentColor(.red)
        
    }
}

struct BaseView_Previews: PreviewProvider {
    static var previews: some View {
        BaseView()
    }
}
