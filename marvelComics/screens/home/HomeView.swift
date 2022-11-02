//
//  ComicsScreen.swift
//  marvelComics
//
//  Created by Abduqaxxor on 3/10/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct HomeView: View {
    
    @StateObject var viewModel = HomeViewModel()
    @Binding var tabSelection: Int
    @FetchRequest(entity: ComicsEntity.entity(), sortDescriptors: []) var comics: FetchedResults<ComicsEntity>
    
    var body: some View {
        NavigationView{
            ScrollView{
                VStack{
                    ForEach(comics, id: \.self){comic in
                        NavigationLink {
                            ComicInformationView(comic: comic)
                        } label: {
                            ComicCell(comic: comic)
                        }
                    }
                    
                    if viewModel.comics.count == viewModel.offset && !viewModel.comics.isEmpty{
                        ProgressView()
                            .onAppear{
                                print("Fetching data")
                                viewModel.getInfoFromServer()
                            }
                    }
                    else{
                        GeometryReader{reader -> Color in
                            
                            let minY = reader.frame(in: .global).minY
                            let height = UIScreen.height / 0.1
                            
                            if !viewModel.comics.isEmpty && minY < height{
                                
                                DispatchQueue.main.async{
                                    viewModel.offset = viewModel.comics.count
                                }
                            }
                            return Color.clear
                        }
                        .frame(width: 20,height: 20)
                    }
                }
                .padding(.vertical)
                if viewModel.isLoading{
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
                if NetworkMonitor.shared.isConnected{
                    PersistenceController.shared.deleteDataOf()
                }
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
