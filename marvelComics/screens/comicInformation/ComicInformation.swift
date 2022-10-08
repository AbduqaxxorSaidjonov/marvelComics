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
    
    //data.creators.items 3 ta writer penciler editor
    //data.textObjects.text
    
    
    var body: some View {
        ScrollView{
            ZStack{
                VStack(alignment: .center){
                    Text(comic.title ?? "")
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                        .padding(.all , 10)
                    if comic.thumbnail?.path != nil && comic.thumbnail?.extension != nil{
                        WebImage(url: URL(string: "\(self.comic.thumbnail!.path!).\(self.comic.thumbnail!.extension!)"))
                            .resizable()
                            .scaledToFill()
                            .frame(width: UIScreen.width / 3, height: UIScreen.height / 3)
                    }
                    VStack(alignment: .leading){
                        if !(comic.dates?.isEmpty ?? true){
                    ForEach(0..<(comic.dates?.count ?? 1)){ index in
                        if comic.dates?[index].type ?? "" ==  "onsaleDate"{
                            HStack{
                                Text("Published date:").fontWeight(.semibold)
                                Text(Utils.dateFormatter(date: comic.dates?[index].date ?? "None Date"))
                            }
                            .padding(.top , 10)
                        }
                    }
                    }
                        if !(comic.creators?.items?.isEmpty ?? true){
                            ForEach(0..<(comic.creators?.items?.count ?? 1)){ index in
                                HStack{
                                    Text("\(comic.creators?.items?[index].role ?? ""):").fontWeight(.semibold)
                                Text(" \(comic.creators?.items?[index].name ?? "")")
                                }
                                .padding(.top , 5)
                            }
                        }
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
