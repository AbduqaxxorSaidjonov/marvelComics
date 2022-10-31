//
//  CoreData.swift
//  marvelComics
//
//  Created by Abduqaxxor on 25/10/22.
//

import Foundation
import CoreData

class CoreData{
    static let sharedInstance = CoreData()
    
    private let container = PersistenceController.shared.container
    
    
}
