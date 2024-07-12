//
//  ShowIconView.swift
//  easylondon
//
//  Created by Saugat Poudel on 11/07/2024.
//

import SwiftUI

struct ShowIconView: View {
    let modes: [String]
    var body: some View {
        if modes.contains("national-rail") {
            Image(systemName:"tram.fill").foregroundColor(.red)
        } else if modes.contains("bus") {
            Image(systemName:"bus.doubledecker.fill").foregroundColor(.red)
        } else {
            Image(systemName:"bus.fill").foregroundColor(.blue)

        }
    }
}
