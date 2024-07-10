//
//  FilterPopView.swift
//  easylondon
//
//  Created by Saugat Poudel on 10/07/2024.
//

import SwiftUI

struct FilterPopView: View {
    @Binding var isBusSelected: Bool
    @Environment(\.presentationMode) var presentationMode
    @Binding var distanceFilter: Double

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Transport Type")) {
                                    Toggle(isOn: $isBusSelected) {
                                        Text("London Bus Only")
                                    }
                                }
                                Section(header: Text("Distance (KM)")) {
                                    Slider(value: $distanceFilter, in: 0...10, step: 0.2) {
                                        Text("Distance")
                                    }
                                    Text("Within \(String(format: "%.1f", distanceFilter)) KM")
                                }
            }.navigationTitle("Filter").navigationBarItems(trailing: Button("Done"){
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}
