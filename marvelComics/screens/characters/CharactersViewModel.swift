//
//  CharactersViewModel.swift
//  marvelComics
//
//  Created by Abduqaxxor on 12/10/22.
//

import Foundation

class CharactersViewModel: ObservableObject{
    
    @Published var characters = [Character]()
    @Published var offset: Int = 0
    @Published var isLoading = true
    
    func getCharactersList(comicId: String){
        AFHttp.get(url: AFHttp.API_COMIC_SINGLE + String(comicId) + AFHttp.API_CHARACTERS_LIST, offset: 0){data in
                let characters = try? JSONDecoder().decode(CharacterDataWrapper.self, from: data)
                self.isLoading = false
                self.characters.append(contentsOf: (characters?.data?.results) ?? [Character]())
            
        }
    }
}
