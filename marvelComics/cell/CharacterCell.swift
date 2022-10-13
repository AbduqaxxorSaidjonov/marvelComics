//
//  CharacterCell.swift
//  marvelComics
//
//  Created by Abduqaxxor on 12/10/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct CharacterCell: View {
    
    var character: Character
    
    var body: some View {
            VStack(alignment: .leading){
                WebImage(url: URL(string: "\(self.character.thumbnail!.path!).\(self.character.thumbnail!.extension!)"))
                    .resizable()
                    .scaledToFill()
                //     .redacted(reason: .placeholder)
                Text(character.name!)
                    .fontWeight(.heavy)
                //                .redacted(reason: .placeholder)
            }
            .padding(.horizontal)
            .padding(.bottom)
        
    }
}

struct CharacterCell_Previews: PreviewProvider {
    static var previews: some View {
        CharacterCell(character: Character())
    }
}
