//
//  CommuteView.swift
//  easylondon
//
//  Created by Saugat Poudel on 12/07/2024.
//

import SwiftUI
import CoreLocation
import SwiftUI
import CoreLocation

struct CommuteView: View {
    @StateObject private var viewModel = CommuteViewModel()
        @State private var isSelectingStart = true
        @State private var showStationSearch = false

        var body: some View {
            VStack(spacing: 20) {
                LocationSelectorButton(
                    title: "Start Location",
                    station: viewModel.startLocation,
                    action: {
                        isSelectingStart = true
                        showStationSearch = true
                    }
                )

                LocationSelectorButton(
                    title: "End Location",
                    station: viewModel.endLocation,
                    action: {
                        isSelectingStart = false
                        showStationSearch = true
                    }
                )

                Button(action: viewModel.searchRoute) {
                    Text("Search Route")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .padding()
            .sheet(isPresented: $showStationSearch) {
                StationSearchView(
                    selectedStation: isSelectingStart ? $viewModel.startLocation : $viewModel.endLocation
                )
            }
            .alert("Error", isPresented: .constant(viewModel.errorMessage != nil), actions: {
                Button("OK") { viewModel.errorMessage = nil }
            }, message: {
                Text(viewModel.errorMessage ?? "")
            })
        }
}

#Preview {
    CommuteView()
}
