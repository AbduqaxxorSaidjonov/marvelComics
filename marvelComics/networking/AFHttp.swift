//
//  AFHttp.swift
//  marvelComics
//
//  Created by Abduqaxxor on 3/10/22.
//

import Foundation
import CryptoKit

private let base_url = "https://gateway.marvel.com:443/v1/public"
private let public_key = "8aba15a1b1d67225fc1f3c097ada6221"
private let private_key = "2c71b7811774dff516dada5fef3c6a8cd80aca84"

class AFHttp{
    
    class func server(url: String,offset: Int) -> String{
        let ts = String(Date().timeIntervalSince1970)
        let hash = MD5(data: "\(ts)\(private_key)\(public_key)")
        let request_url = base_url + url + "?limit=20&offset=\(offset)&ts=" + ts + "&apikey=" + public_key + "&hash=" + hash
        return  request_url
    }
    
    static let API_COMICS_LIST = "/comics"
    static let API_COMIC_SINGLE = "/comics/" //id
   
    class func MD5(data: String) -> String{
        let hash = Insecure.MD5.hash(data: data.data(using: .utf8) ?? Data())
        return hash.map{
            String(format: "%02hhx", $0)
        }.joined()
    }
}

