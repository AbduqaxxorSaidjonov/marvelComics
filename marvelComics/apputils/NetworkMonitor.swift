//
//  NetworkMonitor.swift
//  marvelComics
//
//  Created by Abduqaxxor on 31/10/22.
//

import Foundation
import Network

final class NetworkMonitor: ObservableObject{
    let monitor = NWPathMonitor()
    let queue = DispatchQueue(label: "Monitor")
    
    @Published private(set) var isConnected = true
    
    init(){
        monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                self?.isConnected = path.status == .satisfied ? true : false
            }
        }
        
        monitor.start(queue: queue)
    }
}
