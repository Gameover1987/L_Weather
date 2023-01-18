
import Foundation
import CoreData

final class LocationsCoreDataProvider : LocationsProviderProtocol {
    
    static let shared = LocationsCoreDataProvider()
    
    private init() {
        fetchLocations()
    }
    
    var locations: [LocationEntity] = []
    
    func addLocation(name: String, country: String, latitude: Double, longtitude: Double) -> LocationEntity {
        
        let location = getOrCreateLocation(name: name,
                                           country: country,
                                           latitude: latitude,
                                           longtitude: longtitude,
                                           in: persistentContainer.viewContext)
        
        saveContext()
        
        fetchLocations()
        
        return location
    }
    
    func removeLocation(location: LocationEntity) {
        persistentContainer.viewContext.delete(location)
        
        saveContext()
        
        fetchLocations()
    }
    
    private func fetchLocations() {
        let request = LocationEntity.fetchRequest()
        do {
            request.sortDescriptors = [
            NSSortDescriptor(key: "createdAt", ascending: false),
            NSSortDescriptor(key: "name", ascending: true)
            ]
            locations = try persistentContainer.viewContext.fetch(request)
        } catch {
            print(error)
        }
    }
    
    private func getOrCreateLocation(name: String, country: String, latitude: Double, longtitude: Double, in context: NSManagedObjectContext) -> LocationEntity {
        let request = LocationEntity.fetchRequest()
        request.predicate = NSPredicate(format: "name == %@", name)
        
        if let locationEntity = (try? context.fetch(request))?.first {
            return locationEntity
        }
        else {
            let locationEntity = LocationEntity(context: context)
            locationEntity.name = name
            locationEntity.country = country
            locationEntity.latitude = latitude
            locationEntity.longtitude = longtitude
            locationEntity.createdAt = Date()
            
            return locationEntity
        }
    }
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let appName = Bundle.main.appName
        let container = NSPersistentContainer(name: "L_Weather")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    private func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
