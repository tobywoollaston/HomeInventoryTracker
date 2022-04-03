//
//  ToBuyListView.swift
//  HomeInventoryTracker (iOS)
//
//  Created by Toby Woollaston on 27/03/2022.
//

import SwiftUI

struct ToBuyListView: View {
    
    @ObservedObject private var toBuyListVM: ToBuyListViewModel
    
    init(toBuyListVM: ToBuyListViewModel) {
        self.toBuyListVM = toBuyListVM
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach($toBuyListVM.items) { $item in
                    Toggle(isOn: $item.isChecked) {
                        Text(item.name)
                    }
                    .toggleStyle(CheckboxStyle())
                }
            }
            .navigationTitle("Shopping List (\(toBuyListVM.getCount()))")
        }
        .onAppear {
            toBuyListVM.performFetch()
        }
    }
}

struct ToBuyListView_Previews: PreviewProvider {
    static var previews: some View {
        let context = DataController.shared.container.viewContext
        ToBuyListView(toBuyListVM: ToBuyListViewModel(context: context))
    }
}
