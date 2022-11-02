//
//  ComicInfoViewModel.swift
//  marvelComics
//
//  Created by Abduqaxxor on 7/10/22.
//

import Foundation
import CoreData

class ComicInformationViewModel: ObservableObject{
    
    @Published var comicInfo = Comic()
    
    func getSingleComic(comicId: String,context: NSManagedObjectContext){
        AFHttp.get(url: AFHttp.API_COMIC_SINGLE + comicId, offset: 0){data in
            let comic = try? JSONDecoder().decode(ComicDataWrapper.self, from: data)
            self.comicInfo = comic?.data?.results?.first ?? Comic()
            self.saveComicInfo(context: context)
        }
    }
    
    func saveComicInfo(context: NSManagedObjectContext){
        for creator in comicInfo.creators?.items ?? [CreatorSummary](){
            let creators = Creators(context: context)
            creators.id = String(comicInfo.id ?? 0)
            creators.role = creator.role
            creators.name = creator.name
        }
        
            do{
                try context.save()
            }catch{
                fatalError("Failure to save context: \(error)")
            }
    }
}
