//
//  CountItemTypeView.swift
//  HomeInventoryTracker (iOS)
//
//  Created by Toby Woollaston on 23/03/2022.
//

import SwiftUI

struct CountItemTypeView: View {
    
    @Binding var count: String
    @Binding var lowValue: String
    
    init(count: Binding<String>, lowValue: Binding<String>) {
        self._count = count
        self._lowValue = lowValue
    }
    
    var body: some View {
        CounterView("Count", value: $count)
        CounterView("Low Value", value: $lowValue)
    }
}

struct CountItemTypeView_Previews: PreviewProvider {
    @State static var count = "0"
    @State static var lowValue = "0"
    static var previews: some View {
        Form {
            Section {
                CountItemTypeView(count: $count, lowValue: $lowValue)
            }
        }
    }
}
