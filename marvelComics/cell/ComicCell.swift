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
        VStack(alignment: .leading){
            WebImage(url: comic.image)
                .resizable()
                .scaledToFill()
            //     .redacted(reason: .placeholder)
            Text(comic.title ?? "Optional")
                .fontWeight(.heavy)
            //                .redacted(reason: .placeholder)
        }
        .padding(.horizontal)
        .padding(.bottom)
    }
}

struct ComicCell_Previews: PreviewProvider {
    static var previews: some View {
        ComicCell(comic: ComicsEntity())
    }
}
