//
//  CharactersView.swift
//  marvelComics
//
//  Created by Abduqaxxor on 12/10/22.
//

import SwiftUI

struct CharactersView: View {

    @Environment(\.presentationMode) var presentation
    @StateObject var viewModel = CharactersViewModel()
    var comicId: Int

    var body: some View {
            ScrollView{
                VStack{
                    if !viewModel.isLoading && viewModel.characters.count == 0{
                        VStack{
                            Spacer()
                            Text("Characters not found")
                                .fontWeight(.bold)
                            Spacer()
                        }
                        .frame(maxHeight: .infinity)
                    }else{
                        ForEach(0..<viewModel.characters.count,id: \.self){index in
                            NavigationLink {
                                CharacterInformationView(character: viewModel.characters[index])
                            } label: {
                                CharacterCell(character: viewModel.characters[index])
                            }
                        }
                    }

                    if viewModel.characters.count > 20 && viewModel.characters.count == viewModel.offset && viewModel.characters.count != 0{
                        ProgressView()
                            .onAppear{
                                print("Fetching data")
                                viewModel.getCharactersList(comicId: String(comicId))
                            }
                    }
                    else{
                        GeometryReader{reader -> Color in

                            let minY = reader.frame(in: .global).minY
                            let height = UIScreen.height / 1.3

                            if !viewModel.characters.isEmpty && minY < height{

                                DispatchQueue.main.async{
                                    viewModel.offset = viewModel.characters.count
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
            .navigationBarTitle("Characters", displayMode: .inline)
            .navigationBarItems(leading: Button(action: {
                self.presentation.wrappedValue.dismiss()
            }, label: {
                Image(systemName: "chevron.backward")
            }))
            .onAppear{
                if viewModel.characters.isEmpty{
                    viewModel.getCharactersList(comicId: String(comicId))
                }
            }
            .navigationBarBackButtonHidden(true)
    }
}

struct CharactersView_Previews: PreviewProvider {
    static var previews: some View {
        CharactersView(comicId: 1)
    }
}
