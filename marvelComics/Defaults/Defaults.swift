//
//  Defaults.swift
//  marvelComics
//
//  Created by Abduqaxxor on 23/11/22.
//

import Foundation

struct Defaults {
    static let defaults = UserDefaults.standard
    
    static func saveOrder(order: String, forKey: String) -> String {
        let orderBy = defaults.string(forKey: forKey)
        defaults.setValue(order, forKey: forKey)
        return orderBy ?? "-modified"
    }
    
    static func saveAscending(ascending: String, forKey: String) -> Bool {
        let dataAscending = defaults.bool(forKey: forKey)
        if ascending == "true" {
            defaults.setValue(true, forKey: forKey)
        } else {
            defaults.setValue(false, forKey: forKey)
        }
        
        return dataAscending
    }
}
