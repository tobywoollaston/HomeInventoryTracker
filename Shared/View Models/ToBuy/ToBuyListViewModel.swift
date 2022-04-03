//
//  ToBuyListViewModel.swift
//  HomeInventoryTracker (iOS)
//
//  Created by Toby Woollaston on 28/03/2022.
//

import Foundation
import CoreData

@MainActor
class ToBuyListViewModel: NSObject, ObservableObject {
    
    @Published var items = [ToBuyItemViewModel]()
    
    private let fetchedResultsController: NSFetchedResultsController<ItemEntity>
    private (set) var context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
        self.fetchedResultsController = NSFetchedResultsController(fetchRequest: ItemEntity.lowStock, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        super.init()
        self.fetchedResultsController.delegate = self
    
        performFetch()
    }
    
    func performFetch() {
        do {
            try fetchedResultsController.performFetch()
            updateItems(fetchedResultsController.fetchedObjects)
        } catch {
            print(error)
        }
    }
    
    func getAll() -> [ToBuyItemViewModel] {
        return items
    }
    
    func getCount() -> Int {
        return items.count
    }
    
}

extension ToBuyListViewModel: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        updateItems(controller.fetchedObjects)
    }
    
    private func updateItems(_ result: [Any]?) {
        guard let items = result as? [ItemEntity] else { return }

        self.items = items.map(ToBuyItemViewModel.init)
    }
}
