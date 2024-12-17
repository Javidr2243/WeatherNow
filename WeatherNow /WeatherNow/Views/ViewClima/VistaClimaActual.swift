//
//  VistaClimaActual.swift
//  Actividad8
//
//  Created by JAVIER DAVILA RUIZ on 17/12/24.
//

import SwiftUI

struct VistaClimaView: View {
    var clima: Clima
    
    var body: some View {
        ZStack(alignment: .leading) {
            VStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text(clima.name)
                        .bold()
                        .font(.title)
                        .accessibilityLabel("City name: \(clima.name)")
                    
                    Text("Today, \(Date().formatted(.dateTime.month().day().hour().minute()))")
                        .fontWeight(.light)
                        .accessibilityLabel("Today's date and time: \(Date().formatted(.dateTime.month().day().hour().minute()))")
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer()
                
                VStack {
                    HStack {
                        VStack(spacing: 20) {
                            Image(systemName: "cloud.fill")
                                .font(.system(size: 40))
                                .accessibilityHidden(true) // Decorative icon
                            
                            Text(clima.weather[0].main)
                                .accessibilityLabel("Weather condition: \(clima.weather[0].main)")
                        }
                        .frame(width: 150, alignment: .leading)
                        
                        Spacer()
                        
                        Text(clima.main.feelsLike.roundDouble() + "°")
                            .font(.system(size: 100))
                            .fontWeight(.bold)
                            .padding()
                            .accessibilityLabel("Feels like \(clima.main.feelsLike.roundDouble()) degrees")
                    }
                    
                    AsyncImage(url: URL(string: "https://cdn.pixabay.com/photo/2020/01/24/21/33/city-4791269_960_720.png")) { phase in
                        if let image = phase.image {
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 350)
                                .accessibilityLabel("City landscape image")
                        } else if phase.error != nil {
                            Text("There was an error loading the image.")
                                .accessibilityLabel("Image failed to load")
                        } else {
                            ProgressView()
                                .accessibilityLabel("Loading image")
                        }
                    }
                    
                    Spacer()
                }
                .frame(maxWidth: .infinity)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack {
                Spacer()
                VStack(alignment: .leading, spacing: 20) {
                    Text("Weather Now")
                        .bold()
                        .padding(.bottom)
                        .accessibilityLabel("Current weather details")
                    
                    HStack {
                        ClimaRow(logo: "thermometer", name: "Min Temp", value: clima.main.tempMin.roundDouble() + "°")
                            .accessibilityElement(children: .combine)
                            .accessibilityLabel("Minimum temperature \(clima.main.tempMin.roundDouble()) degrees")
                        
                        Spacer()
                        
                        ClimaRow(logo: "thermometer", name: "Max Temp", value: clima.main.tempMax.roundDouble() + "°")
                            .accessibilityElement(children: .combine)
                            .accessibilityLabel("Maximum temperature \(clima.main.tempMax.roundDouble()) degrees")
                    }
                    
                    HStack {
                        ClimaRow(logo: "wind", name: "Wind speed", value: clima.wind.speed.roundDouble() + "m/s")
                            .accessibilityElement(children: .combine)
                            .accessibilityLabel("Wind speed \(clima.wind.speed.roundDouble()) meters per second")
                        
                        Spacer()
                        
                        ClimaRow(logo: "wind", name: "Humidity", value: "\(clima.main.humidity)%")
                            .accessibilityElement(children: .combine)
                            .accessibilityLabel("Humidity \(clima.main.humidity) percent")
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .padding(.bottom, 10)
                .foregroundColor(Color(hue: 0.534, saturation: 0.716, brightness: 0.31))
                .background(Color("Azulish"))
                .cornerRadius(20)
            }
            .padding(.bottom, 100)
        }
        .edgesIgnoringSafeArea(.bottom)
        .background(Color(hue: 0.534, saturation: 0.716, brightness: 0.31))
        .preferredColorScheme(.dark)
    }
}

#Preview {
    VistaClimaView(clima: previewClima)
}
