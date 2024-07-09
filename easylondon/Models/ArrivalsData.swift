//
//  ArrivalsData.swift
//  easylondon
//
//  Created by Saugat Poudel on 09/07/2024.
//

import Foundation
struct ArrivalsData: Codable, Identifiable{
    let id: String
    let lineId: String?
    let destinationName:String?
    let timeToStation: Int?
}
