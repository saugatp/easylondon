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
                nearbyStations = try await apiService.fetchStations(location: location)
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
}
