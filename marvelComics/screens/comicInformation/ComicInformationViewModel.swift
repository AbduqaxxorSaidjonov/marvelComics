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
        AFHttp.get(url: AFHttp.API_COMIC_SINGLE + String(comicId), offset: 0){comic in
            DispatchQueue.main.async {
                self.isLoading = false
                self.comicInfo = comic.data?.results?.first ?? Comic()
            } 
        }
        
    }
}
