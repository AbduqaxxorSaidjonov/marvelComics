//
//  ViewModel.swift
//  marvelComics
//
//  Created by Abduqaxxor on 4/10/22.
//

import Foundation

class HomeViewModel: ObservableObject{
    
    @Published var comics = [Comic]()
    @Published var offset: Int = 0
    @Published var isLoading = true
    
    func getInfoFromServer(){
            AFHttp.get(url: AFHttp.API_COMICS_LIST, offset: offset){data in
                let comics = try? JSONDecoder().decode(ComicDataWrapper.self, from: data)
                self.isLoading = false
                self.comics.append(contentsOf: (comics?.data?.results) ?? [Comic]())
            }
    }
}
