//
//  SortingSelectionMenuView.swift
//  HomeInventoryTracker (iOS)
//
//  Created by Toby Woollaston on 27/04/2022.
//

import SwiftUI

struct SortingSelectionMenuView: View {
    
    @ObservedObject private var sorting: LocalSettings
    
    @State private var showingAllLocations = false
    
    init(locationsVM: LocationsViewModel) {
        sorting = LocalSettings(locationsVM: locationsVM)
    }
    
    var body: some View {
        List {
            alphabeticallySortingView
            displaySortingView
            showingLocationsView
        }
    }
    
    private var alphabeticallySortingView: some View {
        Section(header: Text("Sort By")) {
            SelectButtonBar(title: "Ascending", checked: sorting.getOrderingSort() == .ascending, action: {
                sorting.setOrderingSort(.ascending)
            })
            SelectButtonBar(title: "Descending", checked: sorting.getOrderingSort() == .descending, action: {
                sorting.setOrderingSort(.descending)
            })
            SelectButtonBar(title: "Created Date", checked: sorting.getOrderingSort() == .createdDate, action: {
                sorting.setOrderingSort(.createdDate)
            })
            SelectButtonBar(title: "Updated Date", checked: sorting.getOrderingSort() == .updatedDate, action: {
                sorting.setOrderingSort(.updatedDate)
            })
        }
    }
    
    private var displaySortingView: some View {
        Section(header: Text("Display")) {
            Button {
                switch (sorting.getDisplayAs()) {
                case .listAll:
                    sorting.setDisplayAs(.groupByLocation)
                    break
                case .groupByLocation:
                    sorting.setDisplayAs(.listAll)
                    break
                }
            } label: {
                HStack {
                    Text("Display as:")
                        .foregroundColor(.primary)
                    Spacer()
                    Text(sorting.getDisplayAsText())
                }
            }
        }
    }
    
    private var showingLocationsView: some View {
        Section {
            SelectButtonBar(title: "Showing Locations", checked: false, action: {
                showingAllLocations.toggle()
            })
            if (showingAllLocations) {
                ForEach(sorting.getLocations()) { location in
                    SelectButtonBar(title: location.name, checked: location.showingOnInventory, action: {
                        // need to show
                    })
                }
                HStack{
                    Button {
                        print("select all locations")
                    } label: {
                        Text("Select All")
                    }
                    .buttonStyle(BorderlessButtonStyle())
                    Spacer()
                    Button {
                        print("deselect all locations")
                    } label: {
                        Text("Deselect All")
                    }
                    .buttonStyle(BorderlessButtonStyle())
                }
            }
        }
    }
    
}

struct SelectButtonBar: View  {
    
    var title: String
    var checked: Bool
    var action: () -> Void
    
    var body: some View {
        HStack {
            Button {
                action()
            } label: {
                Text(title)
                    .foregroundColor(.primary)
            }
            Spacer()
            if (checked) {
                Image(systemName: "checkmark")
                    .foregroundColor(.accentColor)
            }
        }
    }
}

struct SortingSelectionMenuView_Previews: PreviewProvider {
    static var previews: some View {
        let context = DataController.shared.container.viewContext
        SortingSelectionMenuView(locationsVM: LocationsViewModel(context: context))
    }
}
