//
//  NetworkManager.swift
//  marvelComics
//
//  Created by Abduqaxxor on 19/10/22.
//

import Foundation

struct NetworkManager{
    static let environment: NetworkEnvironment = .production
    static let ComicPublicAPIKey = "8aba15a1b1d67225fc1f3c097ada6221"
    static let ComicPrivateAPIKey = "2c71b7811774dff516dada5fef3c6a8cd80aca84"
    private let router = Router<ComicApi>()
}

enum NetworkResponse: String{
    case success
    case authenticationError = "You need to be authenticated first"
    case badRequest = "Bad request"
    case outdated = "The url you requested is outdated"
    case failed = "Network request failed."
    case noData = "Response returned with no data to decode"
    case unableToDecode = "We could not decode the response"
}

enum Result<String>{
    case success
    case failure(String)
}

fileprivate func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String>{
    switch response.statusCode{
    case 200...299: return .success
    case 401...500: return .failure(NetworkResponse.authenticationError.rawValue)
    case 501...599: return .failure(NetworkResponse.badRequest.rawValue)
    case 600: return .failure(NetworkResponse.outdated.rawValue)
    default: return .failure(NetworkResponse.failed.rawValue)
    }
}
/*
func getComics(page: Int,completion: @escaping (_ comics: [ComicDataWrapper]?,_ error: String?) -> ()){
    router.request(.newComics(page: page)){data , response , error in
        if error != nil{
            completion(nil, "Please check your internet connection.")
        }
        if let response = response as? HTTPURLResponse{
            let result = handleNetworkResponse(response)
            
            switch result{
            case .success:
                guard let responseData = data else{
                    completion(nil,NetworkResponse.noData.rawValue)
                    return
                }
                do{
                    let apiResponse = try JSONDecoder().decode(ComicDataWrapper.self, from: responseData)
                    completion(apiResponse.data?.results,nil)
                }catch{
                    completion(nil, NetworkResponse.unableToDecode.rawValue)
                }
            case .failure(let networkFailureError):
                completion(nil , networkFailureError)
            }
        }
    }
}
*/
