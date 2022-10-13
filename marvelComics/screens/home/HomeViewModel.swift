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
            DispatchQueue.main.async {
                let comics = try? JSONDecoder().decode(ComicDataWrapper.self, from: data)
                print(comics)
                self.isLoading = false
                self.comics.append(contentsOf: (comics?.data?.results) ?? [Comic]())
                self.sortingComics()
            }
        }
    }
    
    func sortingComics(){
        var maxIsbnIndex: Int
        
        for i in 0..<(comics.count - 1){
            maxIsbnIndex = i
            for j in i+1..<comics.count{
                if Int(comics[j].isbn?.digitString ?? "0") ?? 0 > Int(comics[maxIsbnIndex].isbn?.digitString ?? "0") ?? 0{
                    maxIsbnIndex = j
                }
            }
            print(comics[i].isbn?.digitString)
            comics.swapAt(maxIsbnIndex, i)
        }
    }
}
