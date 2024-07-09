//
//  ArrivalsViewModel.swift
//  easylondon
//
//  Created by Saugat Poudel on 09/07/2024.
//
import Foundation

@MainActor
class ArrivalsViewModel: ObservableObject {
    @Published var nextArrivals: [ArrivalsData] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    private let apiService = ApiService()
    
    func fetchArrivals(stopId:String) async{
        isLoading = true
            do {
                nextArrivals = try await apiService.fetchNextArrivals(stopId: stopId)
                isLoading = false
            } catch {
                errorMessage = "Failed to fetch items: \(error.localizedDescription)"
                isLoading = false
            }
    }
}
