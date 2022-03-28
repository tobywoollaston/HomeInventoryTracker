//
//  LocationSettingsViewModel.swift
//  HomeInventoryTracker (iOS)
//
//  Created by Toby Woollaston on 22/03/2022.
//

import Foundation
import CoreData

@MainActor
class LocationsViewModel: NSObject, ObservableObject {
    
    @Published private var locations = [LocationViewModel]()
    
    private let fetchedResultsController: NSFetchedResultsController<LocationEntity>
    private (set) var context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
        self.fetchedResultsController = NSFetchedResultsController(fetchRequest: LocationEntity.all, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        super.init()
        self.fetchedResultsController.delegate = self
        
        do {
            try fetchedResultsController.performFetch()
            updateLocations(fetchedResultsController.fetchedObjects)
        } catch {
            print(error)
        }
    }
    
    func getAll() -> [LocationViewModel] {
        return locations
    }
    
    func getCount() -> Int {
        return locations.count
    }
    
    func get(index: Int) -> LocationViewModel {
        return locations[index]
    }
    
    func deleteAt(index: Int) {
        do {
            let location = locations[index]
            guard let location = try context.existingObject(with: location.id) as? LocationEntity else { return }
            
            try location.delete()
        } catch {
            print(error)
        }
    }
    
}

extension LocationsViewModel: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        updateLocations(controller.fetchedObjects)
    }
    
    private func updateLocations(_ result: [Any]?) {
        guard let locations = result as? [LocationEntity] else { return }
        
        self.locations = locations.map(LocationViewModel.init)
    }
}
