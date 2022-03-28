//
//  ItemsViewModel.swift
//  HomeInventoryTracker (iOS)
//
//  Created by Toby Woollaston on 28/03/2022.
//

import Foundation
import CoreData

@MainActor
class ItemsViewModel: NSObject, ObservableObject {
    
    @Published private var _items = [ItemEntity]()
    
    private let fetchedResultsController: NSFetchedResultsController<ItemEntity>
    private (set) var context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
        self.fetchedResultsController = NSFetchedResultsController(fetchRequest: ItemEntity.all, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        super.init()
        self.fetchedResultsController.delegate = self
        
        do {
            try fetchedResultsController.performFetch()
            updateItems(fetchedResultsController.fetchedObjects)
        } catch {
            print(error)
        }
    }
    
    var items: [ItemEntity] {
        self._items
    }
    
}

extension ItemsViewModel: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        updateItems(controller.fetchedObjects)
    }
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChangeContentWith diff: CollectionDifference<NSManagedObjectID>) {
        updateItems(controller.fetchedObjects)
    }
    
    private func updateItems(_ result: [Any]?) {
        guard let items = result as? [ItemEntity] else { return }
        
        self._items = items
    }
}
