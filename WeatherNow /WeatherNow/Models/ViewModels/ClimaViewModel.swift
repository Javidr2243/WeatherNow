//
//  ClimaViewModel.swift
//  Actividad8
//
//  Created by JAVIER DAVILA RUIZ on 17/12/24.
//

import Foundation
import CoreLocation

actor ClimaModel: ObservableObject {
    
    private let climaCache: NSCache<NSString, CacheEntryObjectClima> = NSCache()
    private let geoCache: NSCache<NSString, CacheEntryObjectGeo> = NSCache()
   
    func getCurrentWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) async throws -> Clima {
        if let cached = climaCache["\(latitude)\(longitude)"]{
            switch cached {
            case .ready(let clima):
                return clima
            case .inProgress(let task):
                return try await task.value
            }
        }
        let task = Task<Clima, Error> {
            guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&apikey&units=metric") else { fatalError("Missing URL") }
            
            
            let urlRequest = URLRequest(url: url)
            
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            
            guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error while fetching data") }
            
            let clima = try JSONDecoder().decode(Clima.self, from: data)
            
            return clima
        }
        climaCache["\(latitude)\(longitude)"] = .inProgress(task)
        do{
            let clima = try await task.value
            climaCache["\(latitude)\(longitude)"] = .ready(clima)
            return clima
        }
        catch{
            climaCache["\(latitude)\(longitude)"] = nil
            throw error
        }
    }
        
    
    
    func getGeoData(ciudad: String) async throws -> CityGeoData {
        print("Solicitando datos para \(ciudad)")
           if let cached = geoCache["\(ciudad)"] {
               switch cached {
               case .ready(let geoData):
                   print("Se usó el cache para \(ciudad)")
                   return geoData
               case .inProgress(let task):
                   print("Tarea en progreso para \(ciudad)")
                   return try await task.value
               }
           } else {
               print("No se encontró en el cache \(ciudad)")
           }
        
        let task = Task<CityGeoData, Error>{
            guard let url = URL(string: "https://api.openweathermap.org/geo/1.0/direct?q=\(ciudad)&appid=2ac24745ead1b65e5228e4b4124e47a6") else { fatalError("Missing URL") }
            
            print("url \(url)")
            
            let urlRequest = URLRequest(url: url)
            
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            
            guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error while fetching data") }
            
            let geo = try JSONDecoder().decode(CityGeoData.self, from: data)
            
            return geo
        }
        geoCache["\(ciudad)"] = .inProgress(task)
        do{
            let geo = try await task.value
            geoCache["\(ciudad)"] = .ready(geo)
            print("se actualizo a ready")
            return geo
        }
        catch{
            geoCache["\(ciudad)"] = nil
            throw error
        }
        
    }
    
    func getClimaCiudad(ciudad: String) async throws -> Clima? {
           do {
               // Obtener datos geográficos de la ciudad
               let geoDataArray = try await getGeoData(ciudad: ciudad)
               
               // Asegurar que obtenemos al menos un resultado
               guard let geoData = geoDataArray.first else {
                   // Manejo de error o devolución de nil si no hay datos
                   print("No se encontraron datos geográficos para la ciudad: \(ciudad)")
                   return nil
               }

               // Usar los datos geográficos para obtener el clima
               return try await getCurrentWeather(latitude: geoData.lat, longitude: geoData.lon)
           } catch {
               // Manejo de cualquier error que pueda ocurrir en el proceso
               print("Error al obtener el clima para la ciudad: \(ciudad). \(error)")
               throw error
           }
       }
    
    
    
    
}


