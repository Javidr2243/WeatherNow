//
//  CacheEntryObject.swift
//  Actividad8
//
//  Created by JAVIER DAVILA RUIZ on 17/12/24.
//

import Foundation


// Cache for Clima calls
final class CacheEntryObjectClima{
    let entry : CacheEntryClima
    init(entry: CacheEntryClima) {
        self.entry = entry
    }
}

enum CacheEntryClima {
    case inProgress(Task<Clima, Error>)
    case ready(Clima)
}


// Cache for Geo calls
final class CacheEntryObjectGeo{
    let entry: CacheEntryGeo
    init(entry: CacheEntryGeo){
        self.entry = entry
    }
}

enum CacheEntryGeo{
    case inProgress(Task<CityGeoData, Error>)
    case ready(CityGeoData)
}
