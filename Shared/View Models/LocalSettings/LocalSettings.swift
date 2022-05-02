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
    
    // alphabetical sorting option
    @Published private var _alphabeticalSortingOption: AlphabeticalSortingOption!
    
    func getAlphabeticalSorting() -> AlphabeticalSortingOption {
        return _alphabeticalSortingOption
    }
    
    func setAlphabeticalSorting(_ option: AlphabeticalSortingOption) {
        defaults.set(option.rawValue, forKey: AlphabeticalSortKey)
        _alphabeticalSortingOption = option
    }
    
    func loadDefaults() {
        _alphabeticalSortingOption = AlphabeticalSortingOption.init(rawValue: defaults.string(forKey: AlphabeticalSortKey) ?? AlphabeticalSortingOption.ascending.rawValue)!
    }
    
    
    
}
