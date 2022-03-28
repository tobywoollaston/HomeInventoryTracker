//
//  LocationSettingsView.swift
//  HomeInventoryTracker (iOS)
//
//  Created by Toby Woollaston on 22/03/2022.
//

import SwiftUI

struct LocationsView: View {
    @Environment(\.managedObjectContext) var viewContext
    @State private var showingAddScreen = false
    @ObservedObject private var locationsVM: LocationsViewModel
    
    init(locationsVM: LocationsViewModel) {
        self.locationsVM = locationsVM
    }
    
    private func deleteLocation(at offset: IndexSet) {
        offset.forEach { index in
            locationsVM.deleteAt(index: index)
        }
    }
    
    var body: some View {
        List {
            ForEach(locationsVM.getAll()) { location in
                Text(location.name)
            }.onDelete(perform: deleteLocation)
        }
        .navigationTitle("Locations (\(locationsVM.getCount()))")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    showingAddScreen.toggle()
                } label: {
                    Label("Add Item", systemImage: "plus")
                }
            }
        }
        .sheet(isPresented: $showingAddScreen) {
            AddLocationView(addLocationVM: AddLocationViewModel(context: viewContext))
        }
    }
}

struct LocationSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        let context = DataController.shared.container.viewContext
        LocationsView(locationsVM: LocationsViewModel(context: context))
    }
}
