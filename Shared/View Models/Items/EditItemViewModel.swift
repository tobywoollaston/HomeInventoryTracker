//
//  EditItemViewModel.swift
//  HomeInventoryTracker (iOS)
//
//  Created by Toby Woollaston on 26/03/2022.
//

import Foundation
import CoreData

@MainActor
class EditItemViewModel: NSObject, ObservableObject {
    
    @Published private var item: ItemEntity
    private let locationsVM: LocationsViewModel
    
    init(_ itemId: NSManagedObjectID, context: NSManagedObjectContext) {
        self.locationsVM = LocationsViewModel(context: context)
        if let item = try? context.existingObject(with: itemId) as? ItemEntity {
            self.item = item
        } else {
            self.item = ItemEntity(context: context)
        }
    }
    
    var name: String {
        get {
            item.name ?? "Unknown Item"
        }
        set {
            item.name = newValue
            save()
        }
    }
    
    var location: String {
        get {
            item.location ?? "Unknown Location"
        }
        set {
            item.location = newValue
            save()
        }
    }
    
    var type: ItemType {
        get {
            ItemType(rawValue: item.type ?? "general")!
        }
        set {
            item.type = newValue.rawValue
            save()
        }
    }
    
    var count: String {
        get {
            item.count ?? "0"
        }
        set {
            item.count = newValue
            item.checked = false
            save()
        }
    }
    
    var lowValue: String {
        get {
            item.lowValue ?? "0"
        }
        set {
            item.lowValue = newValue
            item.checked = false
            save()
        }
    }
    
    var quantity: GeneralItemTypeQuantity {
        get {
            GeneralItemTypeQuantity(rawValue: item.quantity ?? "none")!
        }
        set {
            item.quantity = newValue.rawValue
            item.checked = false
            save()
        }
    }
    
    var createdDate: Date {
        get {
            item.createdDate ?? Date()
        }
    }
    
    var updatedDate: Date {
        get {
            item.updatedDate ?? Date()
        }
    }
    
    private func save() {
        item.updatedDate = Date()
//        try? item.save()
    }
    
    func delete () {
        try? item.delete()
    }
    
    func getAllLocations() -> [LocationViewModel] {
        return locationsVM.getAll()
    }
    
}
