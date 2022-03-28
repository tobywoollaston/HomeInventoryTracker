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
    
    var rawItem: ItemEntity {
        self.item
    }
    
}
