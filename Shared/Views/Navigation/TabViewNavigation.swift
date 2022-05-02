//
//  TabViewController.swift
//  HomeInventoryTracker
//
//  Created by Toby Woollaston on 22/03/2022.
//

import SwiftUI

struct TabViewNavigation: View {
    @Environment(\.managedObjectContext) var viewContext
    @State private var selection = 1
    
    var body: some View {
        TabView(selection: $selection) {
            ItemsListView(itemsListVM: ItemsListViewModel(context: viewContext))
                .tabItem {
                    Image(systemName: "books.vertical")
                    Text("Items")
                }
                .tag(1)
            ToBuyListView(toBuyListVM: ToBuyListViewModel(context: viewContext))
                .tabItem {
                    Image(systemName: "list.bullet.rectangle.portrait.fill")
                    Text("Shopping List")
                }
                .tag(2)
            SettingsView()
                .tabItem {
                    Image(systemName: "gearshape")
                    Text("Settings")
                }
                .tag(3)
        }
    }
}

struct TabViewNavigation_Previews: PreviewProvider {
    static var previews: some View {
        TabViewNavigation()
    }
}
