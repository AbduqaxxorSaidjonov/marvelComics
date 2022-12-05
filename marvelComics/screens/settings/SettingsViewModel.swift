//
//  SettingsViewModel.swift
//  marvelComics
//
//  Created by Abduqaxxor on 4/10/22.
//

import Foundation
import CoreData

class SettingsViewModel: ObservableObject {
    
    func saveSettings (order: String, ascending: Bool) {
        let defaults = UserDefaults.standard
        defaults.set(order, forKey: "order")
        defaults.set(ascending, forKey: "ascending")
    }
}
