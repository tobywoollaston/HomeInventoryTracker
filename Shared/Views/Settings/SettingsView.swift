//
//  SettingsView.swift
//  HomeInventoryTracker
//
//  Created by Toby Woollaston on 22/03/2022.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.managedObjectContext) var viewContext
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    // Item details
                    NavigationLink(destination: LocationsView(locationsVM: LocationsViewModel(context: viewContext))) {
                        Text("Locations")
                    }
                }
            }
            .navigationTitle("Settings")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
