//
//  ApiService.swift
//  easylondon
//
//  Created by Saugat Poudel on 08/07/2024.
//

import Foundation
import CoreLocation

class ApiService{
    
    private var appId = "9d8d100bbcf64051b686781fc856a19c"
    private var appKey = "230ada1ab106487991b50c3bcc5531c6"

    func fetchStations(location: CLLocation) async throws -> [StationData]{
        
        let urlString = "https://api.tfl.gov.uk/StopPoint?lat=\(location.coordinate.latitude)&lon=\(location.coordinate.longitude)&modes=bus&stoptypes=NaptanPublicBusCoachTram&radius=3000&app_id=\(appId)&app_key=\(appKey)"
                guard let url = URL(string: urlString) else {
                    throw URLError(.badURL)
                }
                let (data, _) = try await URLSession.shared.data(from: url)
        
                let response = try JSONDecoder().decode(StationApiResponse.self, from: data)
                return response.stopPoints
                
    }
    func fetchNextArrivals(stopId: String) async throws ->[ArrivalsData]{
        let urlString = "https://api.tfl.gov.uk/StopPoint/\(stopId)/Arrivals?app_id=\(appId)&app_key=\(appKey)"
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        let (data, _) = try await URLSession.shared.data(from: url)

        let response = try JSONDecoder().decode([ArrivalsData].self, from: data)
        return response
        
    }
}
 