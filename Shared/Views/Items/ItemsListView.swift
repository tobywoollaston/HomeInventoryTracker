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
    @ObservedObject private var sorting = LocalSettings()
    
    init(itemsListVM: ItemsListViewModel) {
        self.itemsListVM = itemsListVM
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(getItems()) { item in
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
            .onAppear() {
                sorting.loadDefaults()
            }
        }
    }
    
    func getItems() -> [ItemListViewModel] {
        var allItems = itemsListVM.getAll()
        
        switch (sorting.getOrderingSort()) {
        case .ascending:
            allItems.sort(by: ItemListViewModel.sortAlphabeticallyAscending(_:_:))
            break
        case .descending:
            allItems.sort(by: ItemListViewModel.sortAlphabeticallyDescending(_:_:))
            break
        case .createdDate:
            allItems.sort(by: ItemListViewModel.sortByCreatedDate(_:_:))
            break
        case .updatedDate:
            allItems.sort(by: ItemListViewModel.sortByUpdatedDate(_:_:))
            break
        }
        
//        allItems.sort { a, b in
//            return a.name < b.name
//        }
        return allItems
    }
}

struct ItemsListView_Previews: PreviewProvider {
    static var previews: some View {
        let context = DataController.shared.container.viewContext
        ItemsListView(itemsListVM: ItemsListViewModel(context: context))
    }
}

