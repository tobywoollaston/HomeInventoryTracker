//
//  StringNumberStepper.swift
//  HomeInventoryTracker (iOS)
//
//  Created by Toby Woollaston on 23/03/2022.
//

import SwiftUI

struct StringNumberStepper: View {
    
    @Binding var text: String
    private var title: String
    
    init(_ title: String, text: Binding<String>) {
        self._text = text
        self.title = title
    }
    
    var body: some View {
        Stepper(self.title, onIncrement: {
            var number = Int(text) ?? 0
            number += 1
            self.text = String(number)
        }, onDecrement: {
            var number = Int(text) ?? 0
            number -= 1
            self.text = number >= 0 ? String(number) : "0"
        })
    }
}

struct StringNumberStepper_Previews: PreviewProvider {
    @State static var text = "123"
    static var previews: some View {
        StringNumberStepper("String Number Stepper", text: $text)
    }
}
