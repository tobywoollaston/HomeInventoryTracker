//
//  ToBuyItemViewModel.swift
//  HomeInventoryTracker (iOS)
//
//  Created by Toby Woollaston on 31/03/2022.
//

import Foundation
import CoreData

class ToBuyItemViewModel: NSObject, Identifiable {
    
    @Published private var item: ItemEntity
    
    var id: NSManagedObjectID {
        item.objectID
    }
    
    var name: String {
        item.name ?? "Unknown Item"
    }
    
    var isChecked: Bool {
        get {
            item.checked
        }
        set {
            item.checked = newValue
            save()
        }
    }
    
    init(item: ItemEntity) {
        self.item = item
    }
    
    private func save() {
        try? item.save()
    }
    
}
