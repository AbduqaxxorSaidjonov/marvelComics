//
//  JSONParameterEncoder.swift
//  marvelComics
//
//  Created by Abduqaxxor on 17/10/22.
//

import Foundation

public struct JSONParameterEncoder: ParameterEncoder{
    public static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        do {
            let jsonAsData = try JSONSerialization.data(withJSONObject: parameters,options: .prettyPrinted)
            urlRequest.httpBody = jsonAsData
            if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil{
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            }
        }catch{
            throw NetworkError.encodingFailed
        }
    }
}
