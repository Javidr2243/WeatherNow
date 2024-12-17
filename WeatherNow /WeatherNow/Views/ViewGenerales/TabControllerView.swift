//
//  TabControllerView.swift
//  Actividad8
//
//  Created by JAVIER DAVILA RUIZ on 17/12/24.
//

import SwiftUI

struct TabControllerView: View {
    @Binding var clima: Clima?

    var body: some View {
        TabView {
            // Weather Tab
            if let climaActual = clima {
                VistaClimaView(clima: climaActual)
                    .tabItem {
                        Label("Weather", systemImage: "cloud.sun.fill")
                    }
                    .accessibilityLabel("Weather Tab")
                    .accessibilityHint("Shows current weather information")
            } else {
                Text("Loading weather...")
                    .tabItem {
                        Label("Weather", systemImage: "cloud.sun.fill")
                    }
                    .accessibilityLabel("Weather Tab")
                    .accessibilityHint("Weather information is loading")
            }
            
            // Search Tab
            CityList()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass.circle")
                }
                .accessibilityLabel("Search Tab")
                .accessibilityHint("Search for a city to see its weather")
        }
        .tabViewStyle(DefaultTabViewStyle())
        .background(Color.white.opacity(0.7))
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct TabControllerView_Previews: PreviewProvider {
    static var previews: some View {
        TabControllerView(clima: .constant(previewClima))
    }
}
