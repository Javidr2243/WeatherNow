//
//  NSCacheSubscript.swift
//  Actividad8
//
//  Created by JAVIER DAVILA RUIZ on 17/12/24.
//

import Foundation

// Subscript for the Clima cache
extension NSCache where KeyType == NSString, ObjectType == CacheEntryObjectClima {
    subscript(_ latLon: String) -> CacheEntryClima?{
        get{
            let key = latLon as NSString
            let value = object(forKey: key)
            return value?.entry
        }
        set{
            let key = latLon as NSString
            if let entry = newValue{
                let value = CacheEntryObjectClima(entry: entry)
                setObject(value, forKey: key)
            }
            else{
                removeObject(forKey: key)
            }
        }
    }
}

// Subscript for the Geo cache
extension NSCache where KeyType == NSString, ObjectType == CacheEntryObjectGeo{
    subscript(_ city: String) -> CacheEntryGeo?{
        get{
            print("se uso get")
            let key = city as NSString
            let value = object(forKey: key)
            return value?.entry
        }
        set{
            let key = city as NSString
            if let entry = newValue{
                let value = CacheEntryObjectGeo(entry: entry)
                setObject(value, forKey: key)
            }
            else{
                removeObject(forKey: key)
            }
        }
    }
}
