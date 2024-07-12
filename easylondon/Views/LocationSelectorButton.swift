//
//  LocationSelectorButton.swift
//  easylondon
//
//  Created by Saugat Poudel on 12/07/2024.
//

import SwiftUI

struct LocationSelectorButton: View {
    let title: String
    let station: StationData?
    let action: () -> Void

    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)
            Button(action: action) {
                HStack {
                    VStack(alignment: .leading) {
                        Text(station?.name ?? "Select location")
                            .foregroundColor(station == nil ? .gray : .primary)
                        if let station = station {
                            Text("Stop: \(station.id)")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                    }
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundColor(.gray)
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(8)
            }
        }
    }
}
