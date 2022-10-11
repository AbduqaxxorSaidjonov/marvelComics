//
//  ComicInformation.swift
//  marvelComics
//
//  Created by Abduqaxxor on 7/10/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct ComicInformationView: View {
    
    @ObservedObject var viewModel = ComicInformationViewModel()
    var comicId: Int
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        ScrollView{
            ZStack{
                VStack(alignment: .center){
                    Text(viewModel.comicInfo.title ?? "")
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                        .padding(.all , 10)
                    
                    if viewModel.comicInfo.thumbnail?.path != nil && viewModel.comicInfo.thumbnail?.extension != nil{
                        WebImage(url: URL(string: "\(self.viewModel.comicInfo.thumbnail!.path!).\(self.viewModel.comicInfo.thumbnail!.extension!)"))
                            .resizable()
                            .scaledToFill()
                            .frame(width: UIScreen.width / 2, height: UIScreen.height / 2)
                    }
                    VStack(alignment: .leading){
                        if !(viewModel.comicInfo.dates?.isEmpty ?? true){
                            ForEach(0..<(viewModel.comicInfo.dates?.count ?? 1)){ index in
                                if viewModel.comicInfo.dates?[index].type ?? "" ==  "onsaleDate"{
                                    HStack{
                                        Text("Published date: ").fontWeight(.semibold)
                                        Text(Utils.dateFormatter(date: viewModel.comicInfo.dates?[index].date ?? "None Date"))
                                    }
                                }
                            }
                        }
                        if !(viewModel.comicInfo.creators?.items?.isEmpty ?? true){
                            ForEach(0..<(viewModel.comicInfo.creators?.items?.count ?? 1)){ index in
                                HStack{
                                    Text("\((viewModel.comicInfo.creators?.items?[index].role ?? "").uppercased()): ").fontWeight(.semibold)
                                    Text(" \(viewModel.comicInfo.creators?.items?[index].name ?? "")")
                                }
                                .padding(.top ,5)
                            }
                        }
                        if !(viewModel.comicInfo.textObjects?.isEmpty ?? true){
                            ForEach(0..<(viewModel.comicInfo.textObjects?.count ?? 1)){ index in
                                HStack{
                                    Text("Description: ").fontWeight(.semibold) +
                                    Text(viewModel.comicInfo.textObjects?[index].text ?? "No Description")
                                }
                                .padding(.top,5)
                            }
                        }
                        
                    }
                    .padding(.all , 10)
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
            viewModel.getSingleComic(comicId: String(self.comicId))
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct ComicInformationView_Previews: PreviewProvider {
    static var previews: some View {
        ComicInformationView(comicId: 1)
    }
}
