//
//  CheckboxStyle.swift
//  HomeInventoryTracker (iOS)
//
//  Created by Toby Woollaston on 31/03/2022.
//

import SwiftUI

struct CheckboxStyle: ToggleStyle {
 
    func makeBody(configuration: Self.Configuration) -> some View {
        return HStack {
            Image(systemName: configuration.isOn ? "checkmark.circle.fill" : "circle.dashed")
                .resizable()
                .frame(width: 24, height: 24)
                .foregroundColor(configuration.isOn ? .green : .gray)
                .font(.system(size: 20, weight: .bold, design: .default))
                .onTapGesture {
                    configuration.isOn.toggle()
                }
            configuration.label
        }
 
    }
}

//struct CheckboxStyle_Previews: PreviewProvider {
//    static var previews: some View {
//        CheckboxStyle()
//    }
//}
