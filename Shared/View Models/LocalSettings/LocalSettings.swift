//
//  LocalSettings.swift
//  HomeInventoryTracker
//
//  Created by Toby Woollaston on 02/05/2022.
//

import Foundation

@MainActor
class LocalSettings: NSObject, ObservableObject {
    
    private let defaults = UserDefaults.standard
    
    override init() {
        super.init()
        
        DispatchQueue.main.async {
            self.loadDefaults()
        }
    }
    
    // sorting option
    @Published private var _orderingSortOption: OrderingSortOption!
    
    func getOrderingSort() -> OrderingSortOption {
        return _orderingSortOption ?? .ascending
    }
    
    func setOrderingSort(_ option: OrderingSortOption) {
        defaults.set(option.rawValue, forKey: OrderingSortKey)
        _orderingSortOption = option
    }
    
    // display as
    @Published private var _displayAsOption: DisplayAsOption!
    
    func getDisplayAs() -> DisplayAsOption {
        return _displayAsOption ?? .listAll
    }
    
    func getDisplayAsText() -> String {
        switch (_displayAsOption) {
        case .listAll:
            return "List All"
        case .groupByLocation:
            return "Group By Location"
        case .none:
            return ""
        }
    }
    
    func setDisplayAs(_ option: DisplayAsOption) {
        defaults.set(option.rawValue, forKey: DisplayAsKey)
        _displayAsOption = option
    }
    
    //
    
    func loadDefaults() {
        _orderingSortOption = OrderingSortOption.init(rawValue: defaults.string(forKey: OrderingSortKey) ?? OrderingSortOption.ascending.rawValue)!
        
        _displayAsOption = DisplayAsOption.init(rawValue: defaults.string(forKey: DisplayAsKey) ?? DisplayAsOption.listAll.rawValue)!
    }
    
}
