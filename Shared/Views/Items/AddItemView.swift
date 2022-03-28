//
//  AddItemView.swift
//  HomeInventoryTracker
//
//  Created by Toby Woollaston on 22/03/2022.
//

import SwiftUI
import Combine

struct AddItemView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject private var addItemVM: AddItemViewModel
    
    init(addItemVM: AddItemViewModel) {
        self.addItemVM = addItemVM
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Item name", text: $addItemVM.name)

                    Picker("Location", selection: $addItemVM.location) {
                        ForEach(addItemVM.getAllLocations(), id: \.name) { location in
                            Text(location.name)
                        }
                    }
                }
                Section {
                    HStack(alignment: .center) {
                        Text("Quantity Type:").font(.callout).bold()
                        Picker("Type", selection: $addItemVM.type) {
                            ForEach([ItemType.count, ItemType.general], id: \.self) { text in
                                Text(text.rawValue)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }

                    switch (addItemVM.type) {
                    case .count:
                        CountItemTypeView(count: $addItemVM.count, lowValue: $addItemVM.lowValue)
                    case .general:
                        GeneralItemTypeView(quantity: $addItemVM.quantity)
                    }
                }
                Section {
                    Button("Save") {
                        dismiss()
                        addItemVM.save()
                    }
                    .centerHorizontally()
                }
            }
            .navigationTitle("Add item")
            .navigationBarItems(trailing: Button("Cancel", role: .destructive) {
                dismiss()
            })
        }
    }
    
}

struct AddItemView_Previews: PreviewProvider {
    static var previews: some View {
        let context = DataController.shared.container.viewContext
        AddItemView(addItemVM: AddItemViewModel(context: context))
    }
}
