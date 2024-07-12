//
//  CommuteViewModel.swift
//  easylondon
//
//  Created by Saugat Poudel on 12/07/2024.
//

import SwiftUI
import Combine
import CoreLocation

class CommuteViewModel: ObservableObject {
    @Published var startLocation: StationData?
    @Published var endLocation: StationData?
    @Published var stations: [StationData] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var searchQuery: String = ""
        
    private var cancellables = Set<AnyCancellable>()
    private let locationManager = LocationManager()
    private let apiService = ApiService()
    
    init() {
                $searchQuery
                    .debounce(for: .milliseconds(600), scheduler: DispatchQueue.main)
                    .removeDuplicates()
                    .sink { [weak self] query in
                        self?.fetchStations(query: query)
                    }
                    .store(in: &cancellables)
    }
    
    func fetchStations(query: String) {
            guard !query.isEmpty else {
                self.stations = []
                return
            }
            
            isLoading = true
            
            Task {
                do {
                    let stations = try await apiService.searchStation(query: query)
                    DispatchQueue.main.async {
                        self.stations = stations
                        self.isLoading = false
                    }
                } catch {
                    DispatchQueue.main.async {
                        self.errorMessage = error.localizedDescription
                        self.isLoading = false
                    }
                }
            }
        }
        
    
    func updateCurrentLocationStation(_ location: CLLocation) {
            // In a real app, you would use this location to fetch the nearest station from your API
            let currentLocationStation = StationData(
                id: "current",
                commonName: "Current Location",
                distance: 0,
                indicator: "N/A",
                naptanId: "N/A",
                modes: ["current"],
                lines: []
            )
            
            if !stations.contains(where: { $0.id == "current" }) {
                stations.insert(currentLocationStation, at: 0)
            }
        }
        
        func searchRoute() {
            guard let start = startLocation, let end = endLocation else {
                errorMessage = "Please select both start and end locations"
                return
            }
            print("Searching route from \(start.id) to \(end.id)")
            // Implement your route search logic here
        }
}
