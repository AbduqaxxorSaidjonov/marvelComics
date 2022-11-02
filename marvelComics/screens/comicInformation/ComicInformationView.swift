//
//  ComicInformation.swift
//  marvelComics
//
//  Created by Abduqaxxor on 7/10/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct ComicInformationView: View {
    
    @StateObject var viewModel = ComicInformationViewModel()
    var comic: ComicsEntity
    @FetchRequest(entity: Creators.entity(), sortDescriptors: []) var cretorInfo: FetchedResults<Creators>
    @Environment(\.presentationMode) var presentation
    @Environment(\.managedObjectContext) var moc
    
    var body: some View {
        ScrollView{
            ZStack{
                VStack(alignment: .center){
                    Text(comic.comicsTitle ?? "")
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                        .padding(.all , 10)
                    
                    if comic.comicsImgUrl != nil{
                        WebImage(url: comic.comicsImgUrl)
                            .resizable()
                            .scaledToFill()
                    }
                    VStack(alignment: .leading){
                        HStack{
                            Text("Published date: ").fontWeight(.semibold)
                            Text(Utils.dateFormatter(date: comic.date ?? "Published date can't find"))
                        }
                        .padding(.top ,5)
                      
                        ForEach(cretorInfo, id: \.self){creator in
                            if comic.id == creator.id{
                                HStack{
                                    Text("\((creator.role ?? "").uppercased()): ")
                                        .fontWeight(.semibold)
                                    Text(" \(creator.name ?? "")")
                                }
                                .padding(.top , 5)
                            }
                        }
                        HStack{
                            Text("Description: ").fontWeight(.semibold) +
                            Text(comic.comicsDescription ?? "No description")
                        }
                        .padding(.top,5)
                    }
                    .padding(.all , 10)
                    NavigationLink {
                        CharactersView(comicId: Int(comic.id ?? "0") ?? 0)
                    } label: {
                        Text("Comic's Characters")
                            .foregroundColor(Color.white)
                            .font(Font.system(size: 20))
                            .padding(.vertical , 10)
                            .frame(width: UIScreen.width / 1.5)
                            .background(RoundedRectangle(cornerRadius: 10).foregroundColor(Color.red))
                    }
                }
                .padding(.bottom)
            }
        }
        .listStyle(PlainListStyle())
        .navigationBarTitle("Comic's Information",displayMode: .inline)
        .navigationBarItems(leading: Button(action: {
            self.presentation.wrappedValue.dismiss()
        }, label: {
            Image(systemName: "chevron.backward")
        }))
        .navigationBarBackButtonHidden(true)
        .onAppear{
            viewModel.getSingleComic(comicId: comic.id ?? "0", context: moc)
        }
    }
}

struct ComicInformationView_Previews: PreviewProvider {
    static var previews: some View {
        ComicInformationView(comic: ComicsEntity())
    }
}
