//
//  LocationViewModel.swift
//  HomeInventoryTracker (iOS)
//
//  Created by Toby Woollaston on 22/03/2022.
//

import Foundation
import CoreData

struct LocationViewModel: Identifiable {
    
    private var location: LocationEntity
    
    init(location: LocationEntity) {
        self.location = location
    }
    
    var id: NSManagedObjectID {
        location.objectID
    }
    
    var name: String {
        location.name ?? "Unknown Location"
    }
    
    var showingOnInventory: Bool {
        get {
            location.showingOnInventory
        }
        set {
            location.showingOnInventory = newValue
            save()
        }
    }
    
    private func save() {
        try? location.save()
    }
    
}
