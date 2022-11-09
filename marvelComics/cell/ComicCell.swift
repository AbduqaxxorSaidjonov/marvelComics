//
//  ComicCell.swift
//  marvelComics
//
//  Created by Abduqaxxor on 6/10/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct ComicCell: View {
    
    var comic: ComicsEntity
    
    var body: some View {
        HStack{
            WebImage(url: comic.image)
                .resizable()
                .scaledToFit()
                .cornerRadius(20)
            Spacer()
            Text(comic.title ?? "Optinal")
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

struct ComicCell_Previews: PreviewProvider {
    static var previews: some View {
        ComicCell(comic: ComicsEntity())
    }
}
