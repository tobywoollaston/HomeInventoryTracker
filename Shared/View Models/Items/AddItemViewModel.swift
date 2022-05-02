//
//  AddItemViewModel.swift
//  HomeInventoryTracker (iOS)
//
//  Created by Toby Woollaston on 22/03/2022.
//

import Foundation
import CoreData

@MainActor
class AddItemViewModel: NSObject, ObservableObject {
    
    @Published var name: String = ""
    @Published var location: String = ""
    @Published var type: ItemType = .count
    // Count values
    @Published var count: String = ""
    @Published var lowValue: String = ""
    // General values
    @Published var quantity: GeneralItemTypeQuantity = .high
    
    private let locationsVM: LocationsViewModel
    private (set) var context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
        self.locationsVM = LocationsViewModel(context: context)
        super.init()
    }
    
    func getAllLocations() -> [LocationViewModel] {
        return locationsVM.getAll()
    }
    
    func save() {
        let item = ItemEntity(context: context)
        item.createdDate = Date()
        item.updatedDate = Date()
        item.name = name
        item.location = location
        item.type = type.rawValue
        if type == .count {
            item.count = count
            item.lowValue = lowValue
        } else {
            item.quantity = quantity.rawValue
        }
        try? item.save()
    }
    
}
