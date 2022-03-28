//
//  ItemCellView.swift
//  HomeInventoryTracker (iOS)
//
//  Created by Toby Woollaston on 24/03/2022.
//

import SwiftUI

struct ItemCellView: View {
    
    var item: ItemListViewModel
    
    var body: some View {
        HStack {
            Text(item.name)
            Spacer()
            if item.type == .count {
                Text(item.count)
            } else {
                Text(item.quantity.rawValue.uppercased())
            }
        }
    }
    
}

struct ItemCellView_Previews: PreviewProvider {
    static var previews: some View {
        List {
            let context = DataController.shared.container.viewContext
            ItemCellView(item: ItemListViewModel(item: ItemEntity(context: context)))
        }
    }
}
