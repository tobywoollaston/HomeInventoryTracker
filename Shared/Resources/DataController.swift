//
//  DataController.swift
//  HomeInventoryTracker
//
//  Created by Toby Woollaston on 22/03/2022.
//

import CoreData
import Foundation

class DataController: ObservableObject {
    let container: NSPersistentContainer
    static let shared = DataController()
    
    private init() {
        container = NSPersistentContainer(name: "Inventory")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load \(error.localizedDescription)")
            }
        }
    }
}
