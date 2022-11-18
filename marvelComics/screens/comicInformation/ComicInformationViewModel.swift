//
//  ComicInfoViewModel.swift
//  marvelComics
//
//  Created by Abduqaxxor on 7/10/22.
//

import Foundation
import CoreData

class ComicInformationViewModel: ObservableObject{
    
    @Published var comicInfo = [Comic]()
    
    func getSingleComic(comicId: String){
        AFHttp.get(url: AFHttp.API_COMIC_SINGLE + comicId, offset: 0){data in
            let comic = try? JSONDecoder().decode(ComicDataWrapper.self, from: data)
            self.comicInfo = comic?.data?.results ?? [Comic]()
            self.saveComicInfo()
        }
    }
    
    func saveComicInfo(){
        let context = PersistenceController.shared.container.viewContext
        for creator in comicInfo.first?.creators?.items ?? [] {
            let creators = Creators(context: context)
            creators.id = String(comicInfo.first?.id ?? 0)
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
