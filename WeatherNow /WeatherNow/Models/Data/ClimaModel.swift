//
//  ClimaModel.swift
//  Actividad8
//
//  Created by JAVIER DAVILA RUIZ on 17/12/24.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let clima = try? JSONDecoder().decode(Clima.self, from: jsonData)

import Foundation

// MARK: - Clima
struct Clima: Codable {
    let coord: Coord
    let weather: [Weather]
    let base: String
    let main: Main
    let visibility: Int
    let wind: Wind
    let clouds: Clouds
    let dt: Int
    let sys: Sys
    let timezone, id: Int
    let name: String
    let cod: Int
}

// MARK: - Clouds
struct Clouds: Codable {
    let all: Int
}

// MARK: - Coord
struct Coord: Codable {
    let lon, lat: Double
}

// MARK: - Main
struct Main: Codable {
    let temp, feelsLike, tempMin, tempMax: Double
    let pressure, humidity: Int

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure, humidity
    }
}

// MARK: - Sys
struct Sys: Codable {
    let type, id: Int
    let country: String
    let sunrise, sunset: Int
}

// MARK: - Weather
struct Weather: Codable {
    let id: Int
    let main, description, icon: String
}

// MARK: - Wind
struct Wind: Codable {
    let speed: Double
    let deg: Int
}



extension Clima {
    static let placeholder = Clima(
        coord: Coord(lon: 26.0704018, lat: -98.2963932),
        weather: [Weather(id: 0, main: "", description: "Cargando...", icon: "")],
        base: "",
        main: Main(temp: 0.0, feelsLike: 0.0, tempMin: 0.0, tempMax: 0.0, pressure: 0, humidity: 0),
        visibility: 0,
        wind: Wind(speed: 0.0, deg: 0),
        clouds: Clouds(all: 0),
        dt: 0,
        sys: Sys(type: 0, id: 0, country: "", sunrise: 0, sunset: 0),
        timezone: 0, id: 0, name: "", cod: 0
    )
}
