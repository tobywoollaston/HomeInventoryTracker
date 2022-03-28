//
//  LocationEntity+Extensions.swift
//  HomeInventoryTracker (iOS)
//
//  Created by Toby Woollaston on 22/03/2022.
//

import Foundation
import CoreData

extension LocationEntity: BaseEntityModel {
    static var all: NSFetchRequest<LocationEntity> {
        let request = LocationEntity.fetchRequest()
        request.sortDescriptors = []
        return request
    }
}
