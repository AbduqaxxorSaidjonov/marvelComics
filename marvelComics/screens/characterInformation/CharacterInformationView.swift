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
                    
                    ForEach(characterInfo, id: \.self){character in
                        if character.comics != nil{
                            HStack{
                                Text(character.comics ?? "") +
                                Text(",")
                            }
                        }
                    }
                    
                    Text("Stories: ").fontWeight(.semibold).padding(.top, 10)
                        .foregroundColor(.red)
                    
                    ForEach(characterInfo, id: \.self){character in
                        if character.stories != nil{
                            HStack{
                                Text(character.stories ?? "") +
                                Text(",")
                            }
                        }
                    }
                    
                    Text("Events: ").fontWeight(.semibold).padding(.top,10)
                        .foregroundColor(.red)
                    ForEach(characterInfo, id: \.self){character in
                        if character.events != nil{
                            HStack{
                                Text(character.events ?? "") +
                                Text(",")
                            }
                        }
                    }
                    
                    Text("Series: ").fontWeight(.semibold).padding(.top,10)
                        .foregroundColor(.red)
                    
                    ForEach(characterInfo, id: \.self){character in
                        if character.series != nil{
                            HStack{
                                Text(character.series ?? "") +
                                Text(",")
                            }
                        }
                    }
                    
                    
                    if character.characterDescription == ""{
                        Text("Description: ")
                            .fontWeight(.semibold)
                            .foregroundColor(.red) +
                        Text(" No Description")
                    }else{
                        Text("Description: ")
                            .fontWeight(.semibold)
                            .foregroundColor(.red) +
                        Text(character.characterDescription ?? " No Description")
                    }
                }
                .padding(.all , 10)
                
            }
            .padding(.bottom)
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
