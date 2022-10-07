//
//  ComicInformation.swift
//  marvelComics
//
//  Created by Abduqaxxor on 7/10/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct ComicInformation: View {
    
    @ObservedObject var viewModel = ComicInfoViewModel()
    var comicId: Int
    @State var comic: Comic
    @Environment(\.presentationMode) var presentation
    
    //data.results.title
    //data.results.dates
    //data.creators.items 3 ta
    //data.textObjects.text
    
    
    var body: some View {
        ScrollView{
            ZStack{
                VStack(alignment: .center){
                    Text(comic.title ?? "")
                        .font(.system(size: 30))
                        .fontWeight(.bold)
                        .padding(.all , 5)
                    if comic.thumbnail?.path != nil && comic.thumbnail?.extension != nil{
                        WebImage(url: URL(string: "\(self.comic.thumbnail!.path!).\(self.comic.thumbnail!.extension!)"))
                            .resizable()
                            .scaledToFill()
                            .frame(width: UIScreen.width / 3, height: UIScreen.height / 3)
                    }
                }
                .frame(width: UIScreen.width)
                .frame(maxHeight: .infinity)
            }
        }
        .navigationBarTitle("Comic's information",displayMode: .inline)
        .navigationBarItems(leading: Button(action: {
            self.presentation.wrappedValue.dismiss()
        }, label: {
            Image(systemName: "chevron.backward")
        }))
        .onAppear{
            viewModel.getSingleComic(comicId: String(self.comicId)){comic in
                self.comic = comic
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct ComicInformation_Previews: PreviewProvider {
    static var previews: some View {
        ComicInformation(comicId: 1, comic: Comic())
    }
}
