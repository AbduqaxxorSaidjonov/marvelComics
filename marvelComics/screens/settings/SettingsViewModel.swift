//
//  SettingsViewModel.swift
//  marvelComics
//
//  Created by Abduqaxxor on 4/10/22.
//

import Foundation
import CoreData

class SettingsViewModel: ObservableObject {
    
    func saveSettings (order: String, ascending: String) {
        let defaults = UserDefaults.standard
        _ = defaults.string(forKey: "order")
        defaults.setValue(order, forKey: "order")
        if ascending == "true" {
            _ = defaults.bool(forKey: "ascending")
            defaults.setValue(true, forKey: "ascending")
        } else {
            _ = defaults.bool(forKey: "ascending")
            defaults.setValue(false, forKey: "ascending")
        }
    }
}
