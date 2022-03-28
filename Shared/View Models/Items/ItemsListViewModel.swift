//
//  ItemsListViewModel.swift
//  HomeInventoryTracker (iOS)
//
//  Created by Toby Woollaston on 22/03/2022.
//

import Foundation
import CoreData

@MainActor
class ItemsListViewModel: NSObject, ObservableObject {
    
    @Published private var itemsVM: ItemsViewModel
    
    init(context: NSManagedObjectContext) {
        itemsVM = ItemsViewModel(context: context)
        super.init()
    }
    
    func getAll() -> [ItemListViewModel] {
        return itemsVM.items.map(ItemListViewModel.init)
    }
    
    func getCount() -> Int {
        return itemsVM.items.count
    }
    
}
