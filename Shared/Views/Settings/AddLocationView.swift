//
//  AddLocationView.swift
//  HomeInventoryTracker (iOS)
//
//  Created by Toby Woollaston on 22/03/2022.
//

import SwiftUI

struct AddLocationView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject private var addLocationVM: AddLocationViewModel
    
    init(addLocationVM: AddLocationViewModel) {
        self.addLocationVM = addLocationVM
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                }
                Section {
                    TextField("Name", text: $addLocationVM.name)
                }
                Section {
                    Button("Save") {
                        dismiss()
                        addLocationVM.save()
                    }
                    .centerHorizontally()
                }
            }
            .navigationTitle("Add Location")
            .navigationBarItems(trailing: Button("Cancel", role: .destructive) {
                addLocationVM.save()
                dismiss()
            })
        }
    }
}

struct AddLocationView_Previews: PreviewProvider {
    static var previews: some View {
        let context = DataController.shared.container.viewContext
        AddLocationView(addLocationVM: AddLocationViewModel(context: context))
    }
}
