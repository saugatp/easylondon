//
//  ContentView.swift
//  easylondon
//
//  Created by Saugat Poudel on 08/07/2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
                    CommuteView()
                        .tabItem {
                            Label("Commute", systemImage: "tram")
                        }

                    StationListView()
                        .tabItem {
                            Label("Nearby", systemImage: "magnifyingglass")
                        }

                    SettingsView()
                        .tabItem {
                            Label("Settings", systemImage: "gear")
                        }
                }
        
    }
}

struct SettingsView: View {
    var body: some View {
        Text("Settings")
    }
}

#Preview {
    ContentView()
}
