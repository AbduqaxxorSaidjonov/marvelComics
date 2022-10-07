//
//  ViewModel.swift
//  marvelComics
//
//  Created by Abduqaxxor on 4/10/22.
//

import Foundation


class HomeViewModel: ObservableObject{
    
    @Published var comics = [Comic]()
    
    func getInfoFromServer (){
        
        guard let url = URL(string: AFHttp.server(url: AFHttp.API_COMICS_LIST)) else {return}
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

                    let comics = try? decoder.decode(ComicDataWrapper.self, from: data)

                DispatchQueue.main.async {
                    self.comics = (comics?.data?.results) ?? [Comic]()
                }  
                
               
            }
            
        }
        .resume()
    }
}
