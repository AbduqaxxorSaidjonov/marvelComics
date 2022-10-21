//
//  EndPointType.swift
//  marvelComics
//
//  Created by Abduqaxxor on 17/10/22.
//

import Foundation

protocol EndPointType {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: HTTPHeaders? { get }
}
