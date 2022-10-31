//
//  ComicInfoViewModel.swift
//  marvelComics
//
//  Created by Abduqaxxor on 7/10/22.
//

import Foundation

class ComicInformationViewModel: ObservableObject{
    
    @Published var comicInfo = Comic()
    @Published var isLoading = true
    
    func getSingleComic(comicId: String){
        AFHttp.get(url: AFHttp.API_COMIC_SINGLE + comicId, offset: 0){data in
            let comic = try? JSONDecoder().decode(ComicDataWrapper.self, from: data)
            self.isLoading = false
            self.comicInfo = comic?.data?.results?.first ?? Comic()
        }
    }
}
