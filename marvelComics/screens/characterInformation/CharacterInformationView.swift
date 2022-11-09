//
//  CharacterInformationView.swift
//  marvelComics
//
//  Created by Abduqaxxor on 12/10/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct CharacterInformationView: View {
    
    var comicId: String
    var character: Characters
    @Environment(\.presentationMode) var presentation
    @FetchRequest(entity: CharacterInfo.entity(), sortDescriptors: []) var characterInfo: FetchedResults<CharacterInfo>
    @StateObject var viewModel = CharacterInformationViewModel()
    
    var body: some View {
        ScrollView{
            ZStack{
                VStack(alignment: .center){
                    Text(character.title ?? "")
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                        .padding(.all , 10)
                    
                    if character.image != nil{
                        WebImage(url: character.image)
                            .resizable()
                            .scaledToFill()
                    }
                    
                    VStack(alignment:.leading,spacing: 10){
                        HStack{
                            Text("Modified date: ").fontWeight(.semibold)
                                .foregroundColor(.red)
                            Text(Utils.dateFormatter(date: character.modified ?? "None Date"))
                        }
                        
                        Text("Comics: ").fontWeight(.semibold).padding(.top , 10)
                            .foregroundColor(.red)
                        //                    if characterInfo.comics?.count == 0{
                        //                        Text("Can't find comics")
                        //                    }else{
                        ForEach(characterInfo, id: \.self){character in
                                HStack{
                                    Text(character.comics ?? "None comics") +
                                    Text(",")
                                }
                        }
                        
                        //}
                        
                        if character.description == ""{
                            Text("Description: ")
                                .fontWeight(.semibold)
                                .foregroundColor(.red) +
                            Text("Description empty")
                        }else{
                            Text("Description: ")
                                .fontWeight(.semibold)
                                .foregroundColor(.red) +
                            Text(character.characterDescription ?? "None Description")
                        }
                        
                        /*
                         
                         
                         Text("Stories: ").fontWeight(.semibold).padding(.top, 10)
                         .foregroundColor(.red)
                         if character.stories?.items?.count == 0{
                         Text("Can't find stories")
                         }else{
                         ForEach(0..<(character.stories?.items?.count ?? 0)){index in
                         HStack{
                         Text(character.stories?.items?[index].name ?? "None stories") +
                         Text(",")
                         }
                         }
                         }
                         
                         Text("Events: ").fontWeight(.semibold).padding(.top,10)
                         .foregroundColor(.red)
                         if character.events?.items?.count == 0{
                         Text("Can't find events")
                         }else{
                         ForEach(0..<(character.events?.items?.count ?? 0)){index in
                         HStack{
                         Text(character.events?.items?[index].name ?? "None events") +
                         Text(",")
                         }
                         }
                         }
                         Text("Series: ").fontWeight(.semibold).padding(.top,10)
                         .foregroundColor(.red)
                         if character.series?.items?.count == 0{
                         Text("Can't find series")
                         }else{
                         ForEach(0..<(character.series?.items?.count ?? 0)){index in
                         HStack{
                         Text(character.series?.items?[index].name ?? "None series") +
                         Text(",")
                         }
                         }
                         }
                         */
                    }
                    .padding(.all , 10)
                    
                }
                .padding(.bottom)
                
            }
        }
        .navigationBarTitle("Comic's information",displayMode: .inline)
        .navigationBarItems(leading: Button(action: {
            self.presentation.wrappedValue.dismiss()
        }, label: {
            Image(systemName: "chevron.backward")
        }))
        .navigationBarBackButtonHidden(true)
        .onAppear{
            self.viewModel.getCharactersSingle(comicId: comicId, characterID: character.id ?? "")
        }
    }
}

struct CharacterInformationView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterInformationView(comicId: "", character: Characters())
    }
}
