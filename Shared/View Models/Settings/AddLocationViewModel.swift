//
//  AddLocationViewModel.swift
//  HomeInventoryTracker (iOS)
//
//  Created by Toby Woollaston on 22/03/2022.
//

import Foundation
import CoreData

class AddLocationViewModel: ObservableObject {
    @Published var name: String = ""
    
    private (set) var context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
        print("context: ", context)
    }
    
    func save() {
        let location = LocationEntity(context: context)
        location.name = name
        location.showingOnInventory = true
        try? location.save()
    }
}
