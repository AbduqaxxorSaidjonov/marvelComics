//
//  ComicsScreen.swift
//  marvelComics
//
//  Created by Abduqaxxor on 3/10/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct HomeScreen: View {
    
    @ObservedObject var viewModel = HomeViewModel()
    @Binding var tabSelection: Int
    @State private var showingEdit = false
    
    var body: some View {
        NavigationView{
            ScrollView{
            ZStack{
                VStack{ 
                ForEach(0..<viewModel.comics.count , id: \.self){ index in
                    NavigationLink {
                        ComicInformation(comicId: viewModel.comics[index].id!, comic: Comic())
                    } label: {
                        ComicCell(comic: viewModel.comics[index])
                    }
                }
            }
            }
            }
            .listStyle(PlainListStyle())
            .navigationBarTitle("Marvel Comics", displayMode: .inline)
        }
        .onAppear{
            viewModel.getInfoFromServer()
        }
        
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen(tabSelection: .constant(0))
    }
}
