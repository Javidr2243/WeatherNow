//
//  ContentView.swift
//  WeatherNow
//
//  Created by JAVIER DAVILA RUIZ on 17/12/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var locationManager = LocationManager()
    var climaViewModel = ClimaModel()
    @State var clima: Clima?
    
    var body: some View {
        VStack {
            if let location = locationManager.location {
                if let _ = clima {
                    TabControllerView(clima: $clima)
                        .accessibilityLabel("Main Weather Information")
                        .accessibilityHint("Shows weather details and search options")
                } else {
                    LoadingView()
                        .accessibilityElement(children: .combine)
                        .accessibilityLabel("Loading weather data")
                        .accessibilityHint("Please wait while the weather information is being retrieved")
                        .task {
                            do {
                                clima = try await climaViewModel.getCurrentWeather(latitude: location.latitude, longitude: location.longitude)
                            } catch {
                                print("Error getting weather: \(error)")
                            }
                        }
                }
            } else {
                if locationManager.isLoading {
                    LoadingView()
                        .accessibilityElement(children: .combine)
                        .accessibilityLabel("Loading location data")
                        .accessibilityHint("Please wait while your location is being determined")
                } else {
                    BienvenidaView()
                        .environmentObject(locationManager)
                        .accessibilityLabel("Welcome Screen")
                        .accessibilityHint("Prompts you to share your location to display weather information")
                }
            }
        }
        .background(Color(hue: 0.534, saturation: 0.716, brightness: 0.31))
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}
