//
//  Persistence.swift
//  marvelComics
//
//  Created by Abduqaxxor on 3/10/22.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    
    private let fetchRequest = NSFetchRequest<ComicsEntity>(entityName: "ComicsEntity")
    
    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        for _ in 0..<10 {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()
        }
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()
    
    let container: NSPersistentCloudKitContainer
    
    init(inMemory: Bool = false) {
        container = NSPersistentCloudKitContainer(name: "marvelComics")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    
        func saveDataOf(comics: [Comic]){
            self.container.performBackgroundTask{ (context) in
                self.saveDataToCoreData(comics: comics, context: context)
            }
        }
    
    func deleteDataOf(){
        self.container.performBackgroundTask { context in
            self.deleteObjectFromCoreData(context: context)
        }
    }
    
        private func saveDataToCoreData(comics: [Comic], context: NSManagedObjectContext){
            context.perform {
                for comic in comics {
                    let comicsEntity = ComicsEntity(context: context)
                    comicsEntity.id = UUID()
                    comicsEntity.comicsId = String(comic.id ?? 0)
                    comicsEntity.comicsTitle = comic.title
                    comicsEntity.comicsImgUrl = URL(string: "\(comic.thumbnail!.path!).\(comic.thumbnail!.extension!)")
                    comicsEntity.dates = comic.dates?.first?.date
                }
                do{
                    try context.save()
                }catch{
                    fatalError("Failure to save context: \(error)")
                }
            }
        }
    
    private func deleteObjectFromCoreData(context: NSManagedObjectContext){
        do{
            let objects = try context.fetch(fetchRequest)
            _ = objects.map({context.delete($0)})
            try context.save()
        }catch{
            print("Deleting error: \(error)")
        }
    }
}
