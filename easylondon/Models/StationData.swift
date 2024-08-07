//
//  StationData.swift
//  easylondon
//
//  Created by Saugat Poudel on 08/07/2024.
//

import Foundation

struct StationData: Codable, Identifiable{
    let id: String
    let commonName: String?
    var name : String? = ""
    let distance: Float?
    let indicator: String?
    let naptanId: String?
    let modes: [String]?
    let lines: [Lines]?
    
}
struct Lines:Codable, Identifiable{
    let id: String?
    let name: String?
}
