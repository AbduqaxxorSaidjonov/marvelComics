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
            self.saveCharacters(characters: characters?.data?.results ?? [Character](),id: characterID)
        }
    }
    
    func saveCharacters(characters: [Character],id: String){
        let context = PersistenceController.shared.container.viewContext
        let entity = CharacterInfo(context: context)
        for characters in characters{
            if String(characters.id ?? 0) == id{
                for comics in characters.comics?.items ?? [ComicSummary](){
                    entity.comics = comics.name
                }
                for stories in characters.stories?.items ?? [StorySummary](){
                    entity.stories = stories.name
                }
                for events in characters.events?.items ?? [EventSummary](){
                    entity.events = events.name
                }
                for series in characters.series?.items ?? [SeriesSummary](){
                    entity.series = series.name
                }
            }
        }
        do{
            try context.save()
        }catch{
            fatalError("Failure to save context: \(error)")
        }
    }
    
}
