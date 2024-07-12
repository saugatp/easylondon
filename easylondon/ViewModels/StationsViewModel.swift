//
//  StationsViewModel.swift
//  easylondon
//
//  Created by Saugat Poudel on 08/07/2024.
//

import Foundation

@MainActor
class StationsViewModel: ObservableObject{
    @Published var nearbyStations: [StationData] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var isBusSelected: Bool = false
    @Published var distanceFilter: Double = 0.2  // Default distance filter value
    @Published var searchQuery: String = ""


    private let locationManager = LocationManager()
    private let apiService = ApiService()
    
    init(){
        locationManager.startUpdatingLocation()
    }
    func stopUpdating(){
        locationManager.stopUpdatingLocation()
    }
    func fetchStations() async{
        isLoading = true
        if let location = locationManager.location{
            do {
                nearbyStations = try await apiService.fetchStations(location: location, londonBusOnly: isBusSelected, radius: distanceFilter)
                isLoading = false
            } catch {
                errorMessage = "Failed to fetch items: \(error.localizedDescription)"
                isLoading = false
            }
        }else{
            errorMessage = "Failed to obtain location"
            isLoading = false
        }
    }
    var filteredStations: [StationData] {
           if searchQuery.isEmpty {
               return nearbyStations
           } else {
              
               return nearbyStations.filter { $0.commonName?.localizedCaseInsensitiveContains(searchQuery) == true || mergedString(from: $0.lines ?? []).localizedCaseInsensitiveContains(searchQuery) == true }
           }
       }
    
    func mergedString(from list: [Lines]) -> String {
            return list.map{$0.name ?? "" }.joined()
       }
}
