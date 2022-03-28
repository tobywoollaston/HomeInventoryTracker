//
//  BaseEntityModel.swift
//  HomeInventoryTracker (iOS)
//
//  Created by Toby Woollaston on 22/03/2022.
//

import Foundation
import CoreData

protocol BaseEntityModel {
    static var viewContext: NSManagedObjectContext { get }
    func save() throws
    func delete() throws
}

extension BaseEntityModel where Self: NSManagedObject {
    
    static var viewContext: NSManagedObjectContext {
        DataController.shared.container.viewContext
    }
    
    func save() throws {
        try Self.viewContext.save()
    }
    
    func delete() throws {
        Self.viewContext.delete(self)
        try save()
    }
    
}
