//
//  ItemViewModel.swift
//  HomeInventoryTracker (iOS)
//
//  Created by Toby Woollaston on 26/03/2022.
//

import Foundation
import CoreData

class ItemListViewModel: NSObject, Identifiable {
    
    private var item: ItemEntity
    
    var id: NSManagedObjectID {
        item.objectID
    }
    
    var name: String {
        item.name ?? "Unknown Item"
    }
    
    var createdDate: Date {
        item.createdDate ?? Date()
    }
    
    var updatedDate: Date {
        item.updatedDate ?? Date()
    }
    
    var location: String {
        item.location ?? "Unknown Location"
    }
    
    var type: ItemType {
        ItemType(rawValue: item.type ?? "general")!
    }
    
    var count: String {
        item.count ?? "0"
    }
    
    var lowValue: String {
        item.lowValue ?? "0"
    }
    
    var quantity: GeneralItemTypeQuantity {
        GeneralItemTypeQuantity(rawValue: item.quantity ?? "none")!
    }
    
    init(item: ItemEntity) {
        self.item = item
    }
    
}

// sorting
extension ItemListViewModel {
    static func sortAlphabeticallyAscending(_ a: ItemListViewModel, _ b: ItemListViewModel) -> Bool {
        return a.name < b.name
    }
    
    static func sortAlphabeticallyDescending(_ a: ItemListViewModel, _ b: ItemListViewModel) -> Bool {
        return a.name > b.name
    }
    
    static func sortByCreatedDate(_ a: ItemListViewModel, _ b: ItemListViewModel) -> Bool {
        return a.createdDate < b.createdDate
    }
    
    static func sortByUpdatedDate(_ a: ItemListViewModel, _ b: ItemListViewModel) -> Bool {
        return a.updatedDate > b.updatedDate
    }
}
