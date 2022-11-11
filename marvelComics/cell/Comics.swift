//
//  Comics.swift
//  marvelComics
//
//  Created by Abduqaxxor on 10/11/22.
//

import SwiftUI

struct Comics: View {
    
    var character: Character
    
    var body: some View {
        HStack{
            Text(character.comics ?? "None comics") +
            Text(",")
        }
    }
}

struct Comics_Previews: PreviewProvider {
    static var previews: some View {
        Comics()
    }
}
