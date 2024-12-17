//
//  GeoModel.swift
//  Actividad8
//
//  Created by JAVIER DAVILA RUIZ on 17/12/24.
//

import Foundation

// MARK: - CityGeoDatum
struct CityGeoDatum: Codable {
    let name: String
    let localNames: [String: String]
    let lat, lon: Double
    let country: String
    var state: String? // Ahora `state` es opcional

    enum CodingKeys: String, CodingKey {
        case name
        case localNames = "local_names"
        case lat, lon, country, state
    }
}

typealias CityGeoData = [CityGeoDatum]
