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
    
    init(_ item: ItemEntity, context: NSManagedObjectContext) {
        self.locationsVM = LocationsViewModel(context: context)
        self.item = item
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
        try? item.save()
    }
    
    func delete () {
        try? item.delete()
    }
    
    func getAllLocations() -> [LocationViewModel] {
        return locationsVM.getAll()
    }
    
}
