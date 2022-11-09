//
//  CharactersViewModel.swift
//  marvelComics
//
//  Created by Abduqaxxor on 12/10/22.
//

import Foundation
import CoreData

class CharactersViewModel: ObservableObject{
    
    @Published var characters = [Character]()
    @Published var offset: Int = 0
    @Published var isLoading = true
    
    func getCharactersList(comicId: String){
        AFHttp.get(url: AFHttp.API_COMIC_SINGLE + String(comicId) + AFHttp.API_CHARACTERS_LIST, offset: 0){data in
                let characters = try? JSONDecoder().decode(CharacterDataWrapper.self, from: data)
                self.isLoading = false
                self.characters.append(contentsOf: (characters?.data?.results) ?? [Character]())
            self.saveCharacters(characters: characters?.data?.results ?? [Character]())
        }
    }
    
    func saveCharacters(characters: [Character]){
        let context = PersistenceController.shared.container.viewContext
        for character in characters {
            let characterEntity = Characters(context: context)
            characterEntity.id = String(character.id ?? 1)
            characterEntity.title = character.name
            characterEntity.image = URL(string: "\(character.thumbnail!.path!).\(character.thumbnail!.extension!)")
            characterEntity.modified = character.modified
            characterEntity.characterDescription = character.description
        }
        
        do{
            try context.save()
        }catch{
            fatalError("Failure to save context: \(error)")
        }
    }
}
