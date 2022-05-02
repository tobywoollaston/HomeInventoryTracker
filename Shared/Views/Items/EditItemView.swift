//
//  EditItemView.swift
//  HomeInventoryTracker (iOS)
//
//  Created by Toby Woollaston on 26/03/2022.
//

import SwiftUI

struct EditItemView: View {
    
    @Environment(\.dismiss) var dismiss
    @ObservedObject var item: EditItemViewModel
    @State var isEditing: Bool = false
    
    var body: some View {
        Form {
            if isEditing {
                editingBody
            } else {
                viewingBody
            }
        }
        .navigationTitle(item.name)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    isEditing.toggle()
                } label: {
                    if isEditing {
                        Label("Done", systemImage: "scope")
                    } else {
                        Label("Edit", systemImage: "slider.vertical.3")
                    }
                }
            }
        }
    }
    
    private var editingBody: some View {
        Group {
            Section {
                TextField("Item name", text: $item.name)

                Picker("Location", selection: $item.location) {
                    ForEach(item.getAllLocations(), id: \.name) { location in
                        Text(location.name)
                    }
                }
                .pickerStyle(MenuPickerStyle())
            }
            Section {
                HStack(alignment: .center) {
                    Text("Quantity Type:").font(.callout).bold()
                    Picker("Type", selection: $item.type) {
                        ForEach([ItemType.count, ItemType.general], id: \.self) { text in
                            Text(text.rawValue)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }

                switch (item.type) {
                case .count:
                    CountItemTypeView(count: $item.count, lowValue: $item.lowValue)
                case .general:
                    GeneralItemTypeView(quantity: $item.quantity)
                }
            }
            Section {
                Button("Delete") {
                    dismiss()
                    item.delete()
                }
                .foregroundColor(.red)
                .centerHorizontally()
            }
        }
    }
    
    private var viewingBody: some View {
        Group {
            Section {
                HStack {
                    Text("Location:")
                        .foregroundColor(.secondary)
                    Spacer()
                    Text(item.location)
                }
            }
            Section {
                switch (item.type) {
                case .count:
                    CounterView("Count", value: $item.count)
                case .general:
                    GeneralItemTypeView(quantity: $item.quantity)
                }
            }
            Section {
                Text("Created: \(item.createdDate.formatted())")
                Text("Updated: \(item.updatedDate.formatted())")
            }
        }
    }
}

struct EditItemView_Previews: PreviewProvider {
    static var previews: some View {
        let context = DataController.shared.container.viewContext
        NavigationView {
            EditItemView(item: EditItemViewModel(ItemEntity(context: context), context: context))
        }
    }
}
