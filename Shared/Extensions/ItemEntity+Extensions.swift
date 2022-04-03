//
//  ItemEntity+Extensions.swift
//  HomeInventoryTracker (iOS)
//
//  Created by Toby Woollaston on 23/03/2022.
//

import Foundation
import CoreData

extension ItemEntity: BaseEntityModel {
    static var all: NSFetchRequest<ItemEntity> {
        let request = ItemEntity.fetchRequest()
        request.sortDescriptors = []
        return request
    }
    static var lowStock: NSFetchRequest<ItemEntity> {
        let request = ItemEntity.fetchRequest()
        request.sortDescriptors = []
        
        let predicate = NSPredicate(format: "(type == 'count' AND count < lowValue) OR (type == 'general' AND (quantity == 'low' OR quantity == 'none'))")
        request.predicate = predicate
        
        return request
    }
}
