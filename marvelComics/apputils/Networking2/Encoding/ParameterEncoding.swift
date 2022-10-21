//
//  ParameterEncoding.swift
//  marvelComics
//
//  Created by Abduqaxxor on 17/10/22.
//

import Foundation

public typealias Parameters = [String:Any]

public protocol ParameterEncoder {
 static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws
}

public enum NetworkError: String , Error{
    case parametersNil = "Parameters were nil."
    case encodingFailed = "Parameter encoding failed."
    case missingURL = "URL is nil."
}
