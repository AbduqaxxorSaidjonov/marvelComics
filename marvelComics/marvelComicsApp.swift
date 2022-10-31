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
    
    init(){
        NetworkMonitor.shared.startMonitoring()
       let navBarAppearance = UINavigationBarAppearance()
        let tabBarAppearance = UITabBarAppearance()
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.red]
        navBarAppearance.backgroundColor = UIColor.init(Color.red.opacity(0.05))
        tabBarAppearance.backgroundColor = UIColor.init(Color.red.opacity(0.05))
        
        UITabBar.appearance().standardAppearance = tabBarAppearance
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().compactAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
        UINavigationBar.appearance().tintColor = UIColor.red
    }

    var body: some Scene {
        WindowGroup {
            BaseView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
