//
//  SortingSelectionMenuView.swift
//  HomeInventoryTracker (iOS)
//
//  Created by Toby Woollaston on 27/04/2022.
//

import SwiftUI

struct SortingSelectionMenuView: View {
    
    @ObservedObject private var sorting = LocalSettings()
    
    @State private var showingAllLocations = false
    
    var body: some View {
        List {
            alphabeticallySortingView
            Section {
                Text("Group By")
            }
            Section {
                SelectButtonBar(title: "Showing Locations", checked: false, action: {
                    showingAllLocations.toggle()
                })
                if (showingAllLocations) {
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
    
    private var alphabeticallySortingView: some View {
        Section {
            SelectButtonBar(title: "Ascending", checked: sorting.getAlphabeticalSorting() == .ascending, action: {
                sorting.setAlphabeticalSorting(.ascending)
            })
            SelectButtonBar(title: "Descending", checked: sorting.getAlphabeticalSorting() == .descending, action: {
                sorting.setAlphabeticalSorting(.descending)
            })
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
        SortingSelectionMenuView()
    }
}
