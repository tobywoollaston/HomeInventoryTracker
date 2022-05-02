//
//  ContentView.swift
//  Shared
//
//  Created by Toby Woollaston on 22/03/2022.
//

import SwiftUI

struct ItemsListView: View {
    @Environment(\.managedObjectContext) var viewContext
    @State private var showingAddScreen = false
    @ObservedObject private var itemsListVM: ItemsListViewModel
    
    init(itemsListVM: ItemsListViewModel) {
        self.itemsListVM = itemsListVM
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(itemsListVM.getAll()) { item in
                    NavigationLink {
                        EditItemView(item: EditItemViewModel(item.rawItem, context: viewContext))
                    } label: {
                        ItemCellView(item: item)
                    }
                }
            }
            .navigationTitle("Items (\(itemsListVM.getCount()))")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    NavigationLink {
                        SortingSelectionMenuView()
                    } label: {
                        Image(systemName: "line.horizontal.3")
                            .imageScale(.large)
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAddScreen.toggle()
                    } label: {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddScreen) {
                AddItemView(addItemVM: AddItemViewModel(context: viewContext))
            }
        }
    }
}

struct ItemsListView_Previews: PreviewProvider {
    static var previews: some View {
        let context = DataController.shared.container.viewContext
        ItemsListView(itemsListVM: ItemsListViewModel(context: context))
    }
}

