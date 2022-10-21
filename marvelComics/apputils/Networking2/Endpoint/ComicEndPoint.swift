//
//  MovieEndpoint.swift
//  marvelComics
//
//  Created by Abduqaxxor on 19/10/22.
//

import Foundation

enum NetworkEnvironment{
    case qa
    case production
    case staging
}

public enum ComicApi {
    case recommended(id:Int)
    case popular(page:Int)
    case newComics(page:Int)
    case characters(id:Int)
}

extension ComicApi: EndPointType {
    
    var environmentBaseURL : String {
        switch NetworkManager.environment {
        case .production: return "https://gateway.marvel.com:443/v1/public"
        case .qa: return "https://gateway.marvel.com:443/v1/public"
        case .staging: return "https://gateway.marvel.com:443/v1/public"
        }
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        switch self {
        case .recommended(let id):
            return "/comics/\(id)"
        case .popular:
            return "popular"
        case .newComics:
            return "now_playing"
        case .characters(let id):
            return "/comics/\(id)"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        switch self {
        case .newComics(let page):
            return .requestParameters(bodyParameters: nil,
                                      urlParameters: ["page":page,
                                                      "api_key":NetworkManager.ComicPublicAPIKey])
        default:
            return .request
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}
