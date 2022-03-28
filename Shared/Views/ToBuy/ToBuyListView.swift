//
//  ToBuyListView.swift
//  HomeInventoryTracker (iOS)
//
//  Created by Toby Woollaston on 27/03/2022.
//

import SwiftUI

struct ToBuyListView: View {
    var body: some View {
        NavigationView {
            List {
            }
            .navigationTitle("Shopping List (\(0))")
        }
    }
}

struct ToBuyListView_Previews: PreviewProvider {
    static var previews: some View {
        ToBuyListView()
    }
}
