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
            itemsList
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
    
    private var itemsList: some View {
        Group {
            switch (sorting.getDisplayAs()) {
            case .listAll:
                display_listAllView
            case .groupByLocation:
                display_groupByLocation
            }
        }
    }
    
    private var display_listAllView: some View {
        List {
            ForEach(getListAllItems()) { item in
                NavigationLink {
                    EditItemView(item: EditItemViewModel(item.rawItem, context: viewContext))
                } label: {
                    ItemCellView(item: item)
                }
            }
        }
    }
    
    private func getListAllItems() -> [ItemListViewModel] {
        var allItems = itemsListVM.getAll()
        allItems = sortItems(allItems)
        return allItems
    }
    
    private struct GroupedItemListViewModels {
        let groupName: String
        var models: [ItemListViewModel]
    }
    
    private var display_groupByLocation: some View {
        List {
            ForEach(getGroupedItems(), id: \.groupName) { group in
                Section(header: Text(group.groupName)) {
                    ForEach(group.models, id: \.self) { item in
                        NavigationLink {
                            EditItemView(item: EditItemViewModel(item.rawItem, context: viewContext))
                        } label: {
                            ItemCellView(item: item)
                        }
                    }
                }
            }
        }
    }
    
    private func getGroupedItems() -> [GroupedItemListViewModels] {
        var groupedItems = [GroupedItemListViewModels]()
        itemsListVM.getAll().forEach { item in
            let groupedItemIndex = groupedItems.firstIndex { group in
                return group.groupName == item.location
            }
            
            if (groupedItemIndex ?? -1 >= 0) {
                groupedItems[groupedItemIndex!].models.append(item)
            } else {
                groupedItems.append(GroupedItemListViewModels(groupName: item.location, models: [item]))
            }
        }
        return groupedItems
    }
    
    private func sortItems(_ items: [ItemListViewModel]) -> [ItemListViewModel] {
        var items = items
        switch (sorting.getOrderingSort()) {
        case .ascending:
            items.sort(by: ItemListViewModel.sortAlphabeticallyAscending(_:_:))
            break
        case .descending:
            items.sort(by: ItemListViewModel.sortAlphabeticallyDescending(_:_:))
            break
        case .createdDate:
            items.sort(by: ItemListViewModel.sortByCreatedDate(_:_:))
            break
        case .updatedDate:
            items.sort(by: ItemListViewModel.sortByUpdatedDate(_:_:))
            break
        }
        return items
    }
    
}

//struct GroupedItemListViewModels {
//    let groupName: String
//    var models: [ItemListViewModel]
//}

struct ItemsListView_Previews: PreviewProvider {
    static var previews: some View {
        let context = DataController.shared.container.viewContext
        ItemsListView(itemsListVM: ItemsListViewModel(context: context))
    }
}

