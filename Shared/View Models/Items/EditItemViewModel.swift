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
            item.location = newValue.rawValue
            save()
        }
    }
    
    var count: String {
        get {
            item.count ?? "0"
        }
        set {
            item.count = newValue
            save()
        }
    }
    
    var lowValue: String {
        get {
            item.lowValue ?? "0"
        }
        set {
            item.lowValue = newValue
            save()
        }
    }
    
    var quantity: GeneralItemTypeQuantity {
        get {
            GeneralItemTypeQuantity(rawValue: item.quantity ?? "none")!
        }
        set {
            item.quantity = newValue.rawValue
            save()
        }
    }
    
    private func save() {
        try? item.save()
    }
    
    func getAllLocations() -> [LocationViewModel] {
        return locationsVM.getAll()
    }
    
}
