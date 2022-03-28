//
//  ItemsListViewModel.swift
//  HomeInventoryTracker (iOS)
//
//  Created by Toby Woollaston on 22/03/2022.
//

import Foundation
import CoreData

@MainActor
class ItemsListViewModel: NSObject, ObservableObject {
    
    @Published private var items = [ItemListViewModel]()
    
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
    
    func getAll() -> [ItemListViewModel] {
        return items
    }
    
    func getCount() -> Int {
        return items.count
    }
    
}

extension ItemsListViewModel: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        updateItems(controller.fetchedObjects)
    }
    
    private func updateItems(_ result: [Any]?) {
        guard let items = result as? [ItemEntity] else { return }

        self.items = items.map(ItemListViewModel.init)
    }
}
