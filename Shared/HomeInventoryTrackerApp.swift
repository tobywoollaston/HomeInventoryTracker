//
//  HomeInventoryTrackerApp.swift
//  Shared
//
//  Created by Toby Woollaston on 22/03/2022.
//

import SwiftUI

@main
struct HomeInventoryTrackerApp: App {
    
    var body: some Scene {
        WindowGroup {
            TabViewNavigation()
                .environment(\.managedObjectContext, DataController.shared.container.viewContext)
        }
    }
}
