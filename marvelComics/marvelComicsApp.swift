//
//  marvelComicsApp.swift
//  marvelComics
//
//  Created by Abduqaxxor on 3/10/22.
//

import SwiftUI

@main
struct marvelComicsApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
