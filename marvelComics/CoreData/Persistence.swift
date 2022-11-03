//
//  Persistence.swift
//  marvelComics
//
//  Created by Abduqaxxor on 3/10/22.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    
    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        
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
                    comicsEntity.id = String(comic.id ?? 0)
                    comicsEntity.title = comic.title
                    comicsEntity.image = URL(string: "\(comic.thumbnail!.path!).\(comic.thumbnail!.extension!)")
                    
                    for date in comic.dates ?? [ComicDate](){
                        if date.type == "onsaleDate"{
                            comicsEntity.date = date.date
                            comicsEntity.dateType = date.type
                        }
                    }
                    comicsEntity.comicsDescription = comic.textObjects?.first?.text
                }
                do{
                    try context.save()
                }catch{
                    fatalError("Failure to save context: \(error)")
                }
            }
        }
    
    private func deleteObjectFromCoreData(context: NSManagedObjectContext){
        let fetchRequestComics = NSFetchRequest<ComicsEntity>(entityName: "ComicsEntity")
        let fetchRequestCreators = NSFetchRequest<Creators>(entityName: "Creators")
        do{
            let deleteComics = try context.fetch(fetchRequestComics)
            let deleteCreators = try context.fetch(fetchRequestCreators)
            _ = deleteComics.map({context.delete($0)})
            _ = deleteCreators.map({context.delete($0)})
            try context.save()
        }catch{
            print("Deleting error: \(error)")
        }
    }
}
