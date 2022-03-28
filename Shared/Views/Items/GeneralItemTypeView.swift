//
//  GeneralItemTypeView.swift
//  HomeInventoryTracker (iOS)
//
//  Created by Toby Woollaston on 23/03/2022.
//

import SwiftUI

struct GeneralItemTypeView: View {
    
    @Binding var quantity: GeneralItemTypeQuantity
    
    init(quantity: Binding<GeneralItemTypeQuantity>) {
        self._quantity = quantity
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Spacer()
            Text("Quantity:").font(.callout).bold()
            Picker("Type", selection: $quantity) {
                ForEach([GeneralItemTypeQuantity.none,
                         GeneralItemTypeQuantity.low,
                         GeneralItemTypeQuantity.medium,
                         GeneralItemTypeQuantity.high], id: \.self) { text in
                    Text(text.rawValue)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            Spacer()
        }
    }
}

struct GeneralItemTypeView_Previews: PreviewProvider {
    @State static var quantity = GeneralItemTypeQuantity.low
    static var previews: some View {
        Form {
            Section {
                GeneralItemTypeView(quantity: $quantity)
            }
        }
    }
}
