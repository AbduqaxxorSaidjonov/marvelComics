//
//  ComicInfoViewModel.swift
//  marvelComics
//
//  Created by Abduqaxxor on 7/10/22.
//

import Foundation

class ComicInfoViewModel: ObservableObject{
    
    func getSingleComic(comicId: String,completion: ((Comic)->Void)? = nil){
        
        guard let url = URL(string: AFHttp.server(url: AFHttp.API_COMIC_SINGLE + String(comicId))) else {return}
        let session = URLSession.shared
    
        session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("ERROR: \(error.localizedDescription)")
                return
            }else{
                
                guard let data = data, let response = response as? HTTPURLResponse else {
                    print("ERROR: Couldn't read response object")
                    return
                }
                guard response.statusCode == 200 else {
                    print("ERROR: Server responded status \(response.statusCode)")
                    return
                }

                let decoder = JSONDecoder()

                let comic = try! decoder.decode(ComicDataWrapper.self, from: data)
               
                completion?(comic.data?.results?.first ?? Comic())

            }
            
        }
        .resume()
    }
}
