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
    let distance: Float?
    let indicator: String?
    let naptanId: String?
    let modes: [String]?
}
