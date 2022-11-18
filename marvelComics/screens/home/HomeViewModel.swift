//
//  ViewModel.swift
//  marvelComics
//
//  Created by Abduqaxxor on 4/10/22.
//

import Foundation
import CoreData

class HomeViewModel: ObservableObject{
    
    @Published var comics = [Comic]()
    @Published var offset: Int = 0
    @Published var isLoading = true
    
    func getInfoFromServer(){
        AFHttp.get(url: AFHttp.API_COMICS_LIST, offset: offset){data in
            let comics = try? JSONDecoder().decode(ComicDataWrapper.self, from: data)
            self.isLoading = false
            self.comics.append(contentsOf: (comics?.data?.results) ?? [Comic]())
            self.saveComics(comics: self.comics)
        }
    }
    
    func saveComics(comics: [Comic]){
        let context = PersistenceController.shared.container.viewContext
        
        for comic in comics {
            let comicsEntity = ComicsEntity(context: context)
            comicsEntity.id = String(comic.id ?? 0)
            comicsEntity.title = comic.title
            comicsEntity.image = URL(string: "\(comic.thumbnail!.path!).\(comic.thumbnail!.extension!)")
            comicsEntity.uuid = UUID()
            comicsEntity.modified = comic.modified?.toFormat("MMM d,yyyy  HH:mm:ss")
            
            for date in comic.dates ?? [ComicDate](){
                if date.type == "onsaleDate"{
                    comicsEntity.date = date.date
                    comicsEntity.dateType = date.type
                }
            }
            comicsEntity.comicsDescription = comic.textObjects?.first?.text
        }
        
        do{
                try context.save()
        }catch{
            fatalError("Failure to save context: \(error)")
        }
    }
}
