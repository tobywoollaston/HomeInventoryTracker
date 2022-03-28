//
//  NumberField.swift
//  HomeInventoryTracker (iOS)
//
//  Created by Toby Woollaston on 22/03/2022.
//

import Combine
import SwiftUI

struct NumberField: View {

    @Binding var text: String
    private var title: String
    
    init(_ title: String, text: Binding<String>) {
        self._text = text
        self.title = title
    }

    var body: some View {
        TextField(title, text: $text)
            .keyboardType(.numberPad)
            .onReceive(Just(text)) { newValue in
                let filtered = newValue.filter { "0123456789".contains($0) }
                if filtered != newValue {
                    self.text = filtered
                }
            }
            .multilineTextAlignment(.trailing)
            .frame(maxWidth: .infinity)
    }
}

struct NumberField_Previews: PreviewProvider {
    @State static var text = "123"
    static var previews: some View {
        Form {
            Section {
                NumberField("Number Field", text: $text)
            }
        }
    }
}
