//
//  CharacterCell.swift
//  marvelComics
//
//  Created by Abduqaxxor on 12/10/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct CharacterCell: View {
    
    var character: Characters
    
    var body: some View {
        HStack{
            WebImage(url: character.image)
                .resizable()
                .scaledToFit()
                .cornerRadius(20)
            Spacer()
            Text(character.title ?? "Optinal")
                .fontWeight(.heavy)
                .padding(.trailing)
        }
        .frame(maxWidth: .infinity)
        .frame(height: UIScreen.height / 6)
        .background(.black.opacity(0.1))
        .cornerRadius(20)
        .overlay(RoundedRectangle(cornerRadius: 20).stroke(lineWidth: 1).foregroundColor(.red))
        .padding(.horizontal)
    }
}

struct CharacterCell_Previews: PreviewProvider {
    static var previews: some View {
        CharacterCell(character: Characters())
    }
}
