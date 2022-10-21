//
//  HTTPTask.swift
//  marvelComics
//
//  Created by Abduqaxxor on 17/10/22.
//

import Foundation

public typealias HTTPHeaders = [String:String]

public enum HTTPTask{
    case request
    
    case requestParameters(bodyParameters: Parameters?, urlParameters: Parameters?)
    
    case requestParametersAndHeaders(bodyParameters: Parameters? ,
                                     urlParameters: Parameters?,
                                     additionHeaders: HTTPHeaders? )
}
