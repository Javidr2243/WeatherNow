//
//  BienvenidaView.swift
//  Actividad8
//
//  Created by JAVIER DAVILA RUIZ on 17/12/24.
//

import SwiftUI
import CoreLocationUI

struct BienvenidaView: View {
    @EnvironmentObject var locationManager: LocationManager
    
    var body: some View {
        VStack {
            VStack(spacing: 20) {
                Text("Welcome to WeatherNow")
                    .bold()
                    .font(.title)
                    .accessibilityLabel("Welcome to WeatherNow")
                
                Text("Please share your current location to see the weather in your zone")
                    .multilineTextAlignment(.center)
                    .accessibilityLabel("Please share your current location to see the weather in your area")
            }
            .multilineTextAlignment(.center)
            .padding()
            
            LocationButton(.shareCurrentLocation) {
                locationManager.requestLocation()
            }
            .cornerRadius(30)
            .symbolVariant(.fill)
            .foregroundColor(.white)
            .accessibilityLabel("Share Current Location")
            .accessibilityHint("Double-tap to allow access to your location and see the weather")
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(UIColor.systemBackground))
    }
}

#Preview {
    BienvenidaView()
}
