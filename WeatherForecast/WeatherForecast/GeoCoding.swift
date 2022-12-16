//
//  GeoCoding.swift
//  WeatherForecast
//
//  Created by Deye Lei on 12/15/22.
//

import Foundation

struct GeoCoding{
    struct CoordinateByCityName{
        struct GeoLocation:Codable{
            var name: String
            var lat: Double
            var lon: Double
            var country: String
        }
        var geoLocations: [GeoLocation]
    }
    
    struct CoordinateByZipCode:Codable{
        var zip: String
        var name: String
        var lat: Double
        var lon: Double
        var country: String
    }
}
