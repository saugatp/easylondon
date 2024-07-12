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
                            let lines = mergedString(from: station.lines ?? [])
                            NavigationLink{
                                StationDetailsView(stationId: station.naptanId ?? station.id)
                            } label: {
                                HStack(alignment: .center ){
                                    VStack(alignment: .leading){
                                        Text("\(station.commonName!)")
                                        HStack(alignment: .center){
                                            Text("Lines: \(lines)").font(.caption2).foregroundStyle(.gray)
                                            
                                        }
                                    }
                                    Spacer()
                                    Text("\(String(format: "%.2f", (station.distance ?? 0.0)/1000)) KM").foregroundStyle(.gray).font(.caption)
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
func mergedString(from list: [Lines]) -> String {
    if(list.count>3){
        let startIndex = max(0, list.count - 2)
        let lastTwoObjects = Array(list[startIndex..<list.count])
        return lastTwoObjects.map{$0.name ?? "" }.joined(separator: ",")
    }else{
        return list.map{$0.name ?? "" }.joined(separator: ",")
    }
   }
#Preview {
    StationListView()
}
