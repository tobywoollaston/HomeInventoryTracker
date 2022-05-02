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
        return _orderingSortOption ?? .unordered
    }
    
    func setOrderingSort(_ option: OrderingSortOption) {
        defaults.set(option.rawValue, forKey: OrderingSortKey)
        _orderingSortOption = option
    }
    
    func loadDefaults() {
        _orderingSortOption = OrderingSortOption.init(rawValue: defaults.string(forKey: OrderingSortKey) ?? OrderingSortOption.ascending.rawValue)!
    }
    
    
    
}
