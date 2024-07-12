//
//  StationSearchView.swift
//  easylondon
//
//  Created by Saugat Poudel on 12/07/2024.
//

import SwiftUI

struct StationSearchView: View {
    @Binding var selectedStation: StationData?
    @Environment(\.presentationMode) var presentationMode
    @State private var searchText = ""
    @StateObject private var viewmodel = CommuteViewModel()
        var body: some View {
            NavigationView {
                VStack {
                        List(viewmodel.stations) { station in
                            Button(action: {
                                selectedStation = station
                                presentationMode.wrappedValue.dismiss()
                            }) {
                                VStack(alignment: .leading) {
                                    Text(station.name ?? "Unknown")
                                        .font(.headline)
                                    Text("ID: \(station.id)")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                        .searchable(text: $viewmodel.searchQuery)
                }
                .navigationTitle("Select Station")

            }
        }
}
