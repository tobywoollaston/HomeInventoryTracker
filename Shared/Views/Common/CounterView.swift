//
//  CounterView.swift
//  HomeInventoryTracker (iOS)
//
//  Created by Toby Woollaston on 27/03/2022.
//

import SwiftUI

struct CounterView: View {
    
    private let title: String
    @Binding var value: String
    private let textLabelWidthMultipler = 0.3
    
    init(_ title: String, value: Binding<String>) {
        self.title = title
        self._value = value
    }
    
    var body: some View {
        GeometryReader { geometry in
            HStack(alignment: .center) {
                Text("\(title):").font(.callout).bold()
                    .frame(width: geometry.size.width * textLabelWidthMultipler, alignment: .leading)
                NumberField("10", text: $value)
                StringNumberStepper("", text: $value)
            }
        }
    }
}

struct CounterView_Previews: PreviewProvider {
    @State static var count = "0"
    static var previews: some View {
        CounterView("Counter", value: $count)
    }
}
