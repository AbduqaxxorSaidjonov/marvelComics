//
//  ComicsScreen.swift
//  marvelComics
//
//  Created by Abduqaxxor on 3/10/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct HomeView: View {
    
    @ObservedObject var viewModel = HomeViewModel()
    @Binding var tabSelection: Int
    
    var body: some View {
        NavigationView{
            ScrollView{
                VStack{
                    ForEach(viewModel.comics){comic in
                        NavigationLink {
                            ComicInformationView(comicId: comic.id ?? 0)
                        } label: {
                            ComicCell(comic: comic)
                        }
                    }
                    if viewModel.comics.count == viewModel.offset && viewModel.comics.count != 0{
                        ProgressView()
                            .padding(.vertical)
                            .onAppear {
                                print("Fetching new data")
                                viewModel.getInfoFromServer()
                            }
                    }
                    else{
                        GeometryReader{reader -> Color in
                            
                            let minY = reader.frame(in: .global).minY
                            let height = UIScreen.height / 1.3
                            
                            if !viewModel.comics.isEmpty && minY < height{
                                
                                DispatchQueue.main.async{
                                    viewModel.offset =  viewModel.comics.count
                                }
                            }
                            return Color.clear
                        }
                        .frame(width: 20,height: 20)
                    }
                }
                .padding(.vertical)
                if viewModel.comics.isEmpty{
                    ZStack{
                        Color(.systemBackground)
                            .ignoresSafeArea()
                            .opacity(0.8)
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: Color.red))
                            .scaleEffect(2)
                    }
                    .padding(.vertical ,UIScreen.height / 3)
                }
                
            }
            .listStyle(PlainListStyle())
            .navigationBarTitle("Marvel Comics", displayMode: .inline)
        }
        .onAppear{
            if viewModel.comics.isEmpty{
                viewModel.getInfoFromServer()
            }
        }
        
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(tabSelection: .constant(0))
    }
}
