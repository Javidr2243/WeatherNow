//
//  CityDetails.swift
//  Actividad8
//
//  Created by JAVIER DAVILA RUIZ on 17/12/24.
//

import SwiftUI

struct CityDetails: View {
    var ciudad: String

    @ObservedObject var climaViewModel = ClimaModel()
    @State private var clima: Clima?
    @State private var isLoading = true

    var body: some View {
        ZStack(alignment: .leading) {
            if let clima = clima, !isLoading {
                VStack {
                    VStack(alignment: .leading, spacing: 5) {
                        Text(ciudad)
                            .bold()
                            .font(.title)
                            .accessibilityLabel("City name: \(ciudad)")

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
                                    .accessibilityHidden(true) // Skips decorative image

                                Text(clima.weather[0].main)
                                    .accessibilityLabel("Weather condition: \(clima.weather[0].main)")
                            }
                            .frame(width: 150, alignment: .leading)

                            Spacer()

                            Text(clima.main.feelsLike.roundDouble() + "°")
                                .font(.system(size: 80))
                                .fontWeight(.bold)
                                .padding()
                                .accessibilityLabel("Feels like \(clima.main.feelsLike.roundDouble()) degrees Celsius")
                        }

                        // AsyncImage untouched
                        AsyncImage(url: URL(string: "https://cdn.pixabay.com/photo/2020/01/24/21/33/city-4791269_960_720.png")) { phase in
                            if let image = phase.image {
                                image.resizable()
                                     .aspectRatio(contentMode: .fit)
                                     .frame(width: 350)
                                     .accessibilityLabel("City landscape image")
                            } else if phase.error != nil {
                                Text("There was an error loading the image.")
                                    .accessibilityLabel("Image failed to load.")
                            } else {
                                ProgressView()
                                    .accessibilityLabel("Loading city image")
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
                                .accessibilityLabel("Minimum temperature \(clima.main.tempMin.roundDouble()) degrees Celsius")

                            Spacer()

                            ClimaRow(logo: "thermometer", name: "Max Temp", value: clima.main.tempMax.roundDouble() + "°")
                                .accessibilityElement(children: .combine)
                                .accessibilityLabel("Maximum temperature \(clima.main.tempMax.roundDouble()) degrees Celsius")
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
                .padding(.bottom, 100.0)
            } else if isLoading {
                ProgressView()
                    .accessibilityLabel("Loading weather data")
                    .accessibilityHint("Please wait while the weather data is being retrieved")
            } else {
                Text("Info could not be loaded")
                    .accessibilityLabel("Weather information could not be loaded")
                    .accessibilityHint("Please check your internet connection and try again.")
            }
        }
        .onAppear {
            cargarDatosClima()
        }
        .edgesIgnoringSafeArea(.bottom)
        .background(Color(hue: 0.534, saturation: 0.716, brightness: 0.31))
        .preferredColorScheme(.dark)
    }

    private func cargarDatosClima() {
        isLoading = true
        Task {
            do {
                let climaObtenido = try await climaViewModel.getClimaCiudad(ciudad: ciudad)
                self.clima = climaObtenido
            } catch {
                print("Error al obtener el clima: \(error)")
            }
            isLoading = false
        }
    }
}



#Preview {
    CityDetails(ciudad: "Reynosa")
}
