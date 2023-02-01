//
//  LocationFormView_ViewModel.swift
//  WeatherForecast
//
//  Created by Deye Lei on 12/21/22.
//

import Foundation
import SwiftUI

extension LocationFormView{
    @MainActor class ViewModel:ObservableObject{
        
        @Published var zipCode = ""
        @Published var cityName = ""
        
        @Published var unit: Units = .imperial
        
        @Published var lat:Double = 40.7128
        @Published var lon:Double = -74.0060
        
        @Published var alterForm = true
        
        @Published var showAlert = false
        @Published var alertMessage = ""
        
        @Published var showDialog = false
        @Published var locations : [GeoCoding.CoordinateByCityName.GeoLocation] = []
        
        //input country code
        //return name of the country
        func countryName(countryCode: String) ->String{
            let current = Locale(identifier: "en_US")
            return current.localizedString(forRegionCode: countryCode) ?? "unknown country code"
        }
        
        var cityNamePercentEncoding: String{
            cityName.trimmingCharacters(in: .whitespacesAndNewlines).capitalized.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ??  "failed"
        }
        
        var geoApiCityName:String{ "http://api.openweathermap.org/geo/1.0/direct?q=\(cityNamePercentEncoding)&limit=5&appid=4e7641da2c40729611d1770ccec6aed3"
        }


        var geoApiZipCode: String{
            "http://api.openweathermap.org/geo/1.0/zip?zip=\(zipCode)&appid=4e7641da2c40729611d1770ccec6aed3"
        }
        
        var openWeatherApi:String{
            "http://api.openweathermap.org/data/2.5/forecast?lat=\(lat)&lon=\(lon)&appid=4e7641da2c40729611d1770ccec6aed3&units=\(unit == .metric ? "metric" : "imperial")"
        }
        
        func coordinateApiRequest()async{
            if(!cityName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty){
                
                let decoder = JSONDecoder()
                
                guard let ApiURL = URL(string: geoApiCityName)else{
                    showAlert = true
                    alertMessage = "Invalid city name"
                    return
                }
                
                guard let (JsonData,_) = try? await URLSession.shared.data(from: ApiURL) else{
                    showAlert = true
                    alertMessage = "Invalid URL"
                    return
                }
                
                guard let data = try? decoder.decode([GeoCoding.CoordinateByCityName.GeoLocation].self, from: JsonData) else{
                    showAlert = true
                    alertMessage = "failed to decode"
                    return
                }
                
                locations = data
                
            }
            else{
                let decoder = JSONDecoder()
                
                guard let ApiURL = URL(string: geoApiZipCode)else{
                    showAlert = true
                    alertMessage = "Invalid ZipCode"
                    return
                }
                
                guard let (JsonData,_) = try? await URLSession.shared.data(from: ApiURL) else{
                    showAlert = true
                    alertMessage = "Invalid URL"
                    return
                }
                
                guard let data = try? decoder.decode(GeoCoding.CoordinateByZipCode.self, from: JsonData) else{
                    showAlert = true
                    alertMessage = "failed to decode"
                    return
                }
                lat = data.lat
                lon = data.lon
            }
        }
        
        func weatherApiRequest()async ->OpenWeather?{
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .formatted(formatter)
            
            guard let ApiURL = URL(string: openWeatherApi)else{
                showAlert = true
                alertMessage = "invaild url"
                return nil
            }
            
            guard let (JSONData, _) = try? await URLSession.shared.data(from: ApiURL) else{
                showAlert = true
                alertMessage = "fail to load, try again"
                return nil
            }
            
            do{
                let openWeather = try decoder.decode(OpenWeather.self, from: JSONData)
                print("load success")
                return openWeather
            }
            catch{
                print(error)
                return nil
            }
        }
        
        var numberFormatter: NumberFormatter{
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            return numberFormatter
        }
        
        var disableCondition:Bool{
            if alterForm == false{
                return zipCode.isEmpty && cityName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
            }
            return false
        }
    }
}
