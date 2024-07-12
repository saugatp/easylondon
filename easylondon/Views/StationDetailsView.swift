//
//  StationDetailsView.swift
//  easylondon
//
//  Created by Saugat Poudel on 09/07/2024.
//

import SwiftUI

struct StationDetailsView: View {
    @StateObject private var arrivalsViewModel = ArrivalsViewModel()

    let stationId: String
    var arrivals: [ArrivalsData] {
        arrivalsViewModel.nextArrivals.sorted { ($0.timeToStation ?? 0) < ($1.timeToStation ?? 1) }
    }
    var body: some View {
        Group{
            if arrivalsViewModel.isLoading {
                                ProgressView("Loading stations...")
                                    .progressViewStyle(CircularProgressViewStyle())
                            }
            else{
                List{
                    ForEach(arrivals){ arrival in
                        HStack{
                            Image(systemName:"bus.doubledecker.fill").foregroundColor(.red)
                            Text("\(arrival.lineId!) to \(arrival.destinationName ?? "nil")").font(.caption)
                            Spacer()
                            Text("\((arrival.timeToStation ?? 0) / 60) Minutes").foregroundStyle(.gray).font(.caption2)
                        }
                    }
                }
            }
        }
        .navigationTitle("Next Buses")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    Task {
                        await arrivalsViewModel.fetchArrivals(stopId: stationId)
                    }
                }) {
                    Image(systemName: "arrow.clockwise")
                }
            }
        }
        .task{
            await arrivalsViewModel.fetchArrivals(stopId: stationId)
        }
    }
}

#Preview {
    StationDetailsView(stationId: "96")
}
