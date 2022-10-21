//
//  CharacterInformationView.swift
//  marvelComics
//
//  Created by Abduqaxxor on 12/10/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct CharacterInformationView: View {
    
    var character: Character
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        ScrollView{
            ZStack{
                VStack(alignment: .center){
                    Text(character.name ?? "")
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                        .padding(.all , 10)
                    
                    if character.thumbnail?.path != nil && character.thumbnail?.extension != nil{
                        WebImage(url: URL(string: "\(self.character.thumbnail!.path!).\(self.character.thumbnail!.extension!)"))
                            .resizable()
                            .scaledToFill()
                            .frame(width: UIScreen.width / 2, height: UIScreen.height / 2)
                    }
                    VStack(alignment:.leading,spacing: 10){
                        HStack{
                            Text("Modified date: ").fontWeight(.semibold)
                                .foregroundColor(.red)
                            Text(Utils.dateFormatter(date: character.modified ?? "None Date"))
                        }
                        Text("Comics: ").fontWeight(.semibold).padding(.top , 10)
                            .foregroundColor(.red)
                        if character.comics?.items?.count == 0{
                            Text("Can't find comics")
                        }else{
                            ForEach(0..<(character.comics?.items?.count ?? 0)){index in
                                HStack{
                                    Text(character.comics?.items?[index].name ?? "None comics") +
                                    Text(",")
                                }
                            }
                        }
                        
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
                        if character.description == ""{
                            Text("Description: ")
                                .fontWeight(.semibold)
                                .foregroundColor(.red) +
                            Text("Description empty")
                        }else{
                            Text("Description: ")
                                .fontWeight(.semibold)
                                .foregroundColor(.red) +
                            Text(character.description ?? "None Description")
                        }
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
    }
}

struct CharacterInformationView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterInformationView(character: Character())
    }
}
