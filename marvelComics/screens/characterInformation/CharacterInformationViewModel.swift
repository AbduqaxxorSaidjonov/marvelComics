//
//  CharacterInformationViewModel.swift
//  marvelComics
//
//  Created by Abduqaxxor on 12/10/22.
//

import Foundation

class CharacterInformationViewModel: ObservableObject{
    
    
    @Published var characterInfo = [Character]()
    @Published var offset: Int = 0
    @Published var isLoading = true
    
    func getCharactersSingle(comicId: String, characterID: String){
        AFHttp.get(url: AFHttp.API_COMIC_SINGLE + comicId + AFHttp.API_CHARACTERS_LIST, offset: 0){data in
            let characters = try? JSONDecoder().decode(CharacterDataWrapper.self, from: data)
            self.isLoading = false
            self.characterInfo = characters?.data?.results ?? [Character]()
            for character in self.characterInfo{
                if String(character.id ?? 0) == characterID{
                    self.saveCharacters(character: character)
                }
            }
        }
    }
    
    func saveCharacters(character: Character){
        let context = PersistenceController.shared.container.viewContext
        for comics in character.comics?.items ?? [ComicSummary](){
            CharacterInfo(context: context).comics = comics.name
        }
        for stories in character.stories?.items ?? [StorySummary](){
            CharacterInfo(context: context).stories = stories.name
        }
        for events in character.events?.items ?? [EventSummary](){
            CharacterInfo(context: context).events = events.name
        }
        for series in character.series?.items ?? [SeriesSummary](){
            CharacterInfo(context: context).series = series.name
        }
        CharacterInfo(context: context).id = String(character.id ?? 0)
        do{
            try context.save()
        }catch{
            fatalError("Failure to save context: \(error)")
        }
        
    }
    
}
