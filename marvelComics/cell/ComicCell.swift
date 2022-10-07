//
//  ComicCell.swift
//  marvelComics
//
//  Created by Abduqaxxor on 6/10/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct ComicCell: View {
    
    var comic: Comic

    var body: some View {
        VStack(alignment: .leading){
            WebImage(url: URL(string: "\(self.comic.thumbnail!.path!).\(self.comic.thumbnail!.extension!)"))
                .resizable()
                .scaledToFill()
//                .redacted(reason: .placeholder)
            Text(comic.title!)
                .fontWeight(.heavy)
//                .redacted(reason: .placeholder)
        }
        .padding(.trailing)
        .padding(.leading)
        .padding(.bottom)
    }
}

struct ComicCell_Previews: PreviewProvider {
    static var previews: some View {
        ComicCell(comic: Comic())
    }
}
