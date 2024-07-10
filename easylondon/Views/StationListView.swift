//
//  StationListView.swift
//  easylondon
//
//  Created by Saugat Poudel on 08/07/2024.
//

import SwiftUI

struct StationListView: View {
    @StateObject private var stationsViewmodel = StationsViewModel()
    @State private var showFilter = false

    var stations: [StationData] {
        stationsViewmodel.filteredStations
    }
    var body: some View {
        NavigationSplitView{
            Group{
                if stationsViewmodel.isLoading {
                                    ProgressView("Loading stations...")
                                        .progressViewStyle(CircularProgressViewStyle())
                                }
                else{
                    List{
                        ForEach(stations){ station in

                            NavigationLink{
                                StationDetailsView(stationId: station.naptanId ?? station.id)
                            } label: {
                                HStack{
                                    Image(systemName: station.modes!.contains("bus") ? "bus.doubledecker.fill": "bus.fill").foregroundColor(
                                        station.modes!.contains("bus") ? .red : .blue)
                                    Text("\(station.commonName!)")
                                    Spacer()
                                    Text("\(String(format: "%.2f", (station.distance ?? 0.0)/1000)) KM").foregroundStyle(.gray)
                                }
                            }
                        }
                    }.searchable(text: $stationsViewmodel.searchQuery)
                    
                    
                }
            }.navigationTitle("Nearby Stations")
                .toolbar {
                                ToolbarItem(placement: .navigationBarTrailing) {
                                    Button(action: {
                                        showFilter.toggle()
                                    }) {
                                        Image(systemName: "line.horizontal.3.decrease.circle")
                                    }
                                }
                                ToolbarItem(placement: .navigationBarTrailing) {
                                    Button(action: {
                                        Task {
                                            await stationsViewmodel.fetchStations()
                                        }
                                    }) {
                                        Image(systemName: "arrow.clockwise")
                                    }
                                }
                            }
            
        }
        detail: {
            Text("Select a station")
        }
        .task {
            await stationsViewmodel.fetchStations()
        }
        .sheet(isPresented: $showFilter) {
            FilterPopView(isBusSelected: $stationsViewmodel.isBusSelected,distanceFilter: $stationsViewmodel.distanceFilter)
                .onDisappear {
                    Task {
                        await stationsViewmodel.fetchStations()
                    }
                }
        }
        .alert("Error", isPresented: .constant(stationsViewmodel.errorMessage != nil), actions: {
            Button("OK") { stationsViewmodel.errorMessage = nil }
        }, message: {
            Text(stationsViewmodel.errorMessage ?? "")
        }).onDisappear{
            stationsViewmodel.stopUpdating()
        }
    }
}

#Preview {
    StationListView()
}
