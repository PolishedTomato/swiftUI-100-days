//
//  OpenWeather.swift
//  WeatherForecast
//
//  Created by Deye Lei on 12/13/22.
//

import Foundation

struct OpenWeather: Codable{
    //WeatherForcase
    struct WeatherForcast:Codable{
        static func nextNDay(offset:Int)-> Date{
            var dateComponent = DateComponents()
            dateComponent.day = offset
            return Calendar.current.date(byAdding: dateComponent, to: Date.now) ?? Date.now
        }
        
        static var sampleData: [WeatherForcast] {
            return [
                WeatherForcast(dt: 1, main: MainInfo(temp: 200, feels_like: 200, temp_min: 200, temp_max: 200, pressure: 1000, sea_level: 4, grnd_level: 5, humidity: 6, temp_kf: 7), weather: [Weather(id: 0, main: "Rain", description: "slighly Rain", icon: "01")], clouds: Clouds(all: 10),wind: Wind(speed: 0.1, deg: Int(0.1), gust: 0.1), visibility: 1000, dt_txt: Date.now),
                
                WeatherForcast(dt: 2, main: MainInfo(temp: 200, feels_like: 200, temp_min: 200, temp_max: 200, pressure: 1000, sea_level: 4, grnd_level: 5, humidity: 6, temp_kf: 7), weather: [Weather(id: 0, main: "Snow", description: "HeavySnow", icon: "01")], clouds: Clouds(all: 20),wind: Wind(speed: 0.1, deg: Int(0.1), gust: 0.1), visibility: 1000, dt_txt: Date.now)
            ]
        }
        
        struct MainInfo: Codable{
            var temp:Double
            var feels_like: Double
            var temp_min: Double
            var temp_max: Double
            var pressure: Int
            var sea_level: Int
            var grnd_level: Int
            var humidity: Int
            var temp_kf: Double
        }
        
        
        struct Weather:Codable{
            var id: Int
            var main: String
            var description: String
            var icon: String
        }
            
        
        struct Clouds:Codable{
            var all:Int
        }
        
        struct Wind:Codable{
            var speed: Double
            var deg: Int
            var gust: Double
        }
        
        struct Rain: Codable{
            enum CodingKeys:String, CodingKey{
                case threeH = "3h"
            }
            var threeH : Double
        }
        
        struct Snow:Codable{
            enum CodingKeys: String, CodingKey{
                case threeH = "3h"
            }
            var threeH : Double
        }
        
        struct Sys:Codable{
            var pod:String
        }
        var dt: Int
        var main: MainInfo
        var weather: [Weather]
        var clouds: Clouds
        var wind: Wind
        var visibility: Int
        var pop: Double?
        var rain: Rain?
        var snow: Snow?
        var sys: Sys?
        var dt_txt: Date
    }
    //weather forcast end
    
    struct City: Codable{
        struct Coordinates: Codable{
            var lat: Double
            var lon: Double
        }
        
        static var sampleDate:City{
            return City(id: 0, name: "New York", coord: Coordinates(lat: 10, lon: 10), country: "American", population: 1000, timezone: 100, sunrise: 500, sunset: 500)
        }
        
        var id: Int
        var name: String
        var coord: Coordinates
        var country: String
        var population: Int
        var timezone: Int
        var sunrise: Int
        var sunset: Int
        
        var sunriseTime: String{
            let time = Date(timeIntervalSince1970: TimeInterval(sunrise))
            return time.formatted(date: .omitted, time: .shortened)
        }
        
        var sunsetTime:String{
            let time = Date(timeIntervalSince1970: TimeInterval(sunset))
            return time.formatted(date: .omitted, time: .shortened)
        }
    }
    
    var cod: String
    var message: Int
    var cnt: Int
    var list: [WeatherForcast]
    var city: City
    
    var currentDate: Date{
        Date.now
    }
    
    var TodayForcast: [WeatherForcast]{
        let Today = currentDate
        
        return list.filter { WeatherForcast in
            Calendar.current.isDate(Today, inSameDayAs: WeatherForcast.dt_txt)
        }
    }
    
    var NextDayForcast: [WeatherForcast]{
        var dateComponent = DateComponents()
        dateComponent.day = 1
        let NextDay = Calendar.current.date(byAdding: dateComponent, to: currentDate)
        
        guard let NextDay = NextDay else{return []}
        
        return list.filter { WeatherForcast in
            Calendar.current.isDate(NextDay, inSameDayAs: WeatherForcast.dt_txt)
        }
    }
    
    var Next2DayForcast: [WeatherForcast]{
        var dateComponent = DateComponents()
        dateComponent.day = 2
        let NextDay = Calendar.current.date(byAdding: dateComponent, to: currentDate)
        
        guard let NextDay = NextDay else{return []}
        
        return list.filter { WeatherForcast in
            Calendar.current.isDate(NextDay, inSameDayAs: WeatherForcast.dt_txt)
        }
    }
    
    var Next3DayForcast: [WeatherForcast]{
        var dateComponent = DateComponents()
        dateComponent.day = 3
        let NextDay = Calendar.current.date(byAdding: dateComponent, to: currentDate)
        
        guard let NextDay = NextDay else{return []}
        
        return list.filter { WeatherForcast in
            Calendar.current.isDate(NextDay, inSameDayAs: WeatherForcast.dt_txt)
        }
    }
    
    var Next4DayForcast: [WeatherForcast]{
        var dateComponent = DateComponents()
        dateComponent.day = 4
        let NextDay = Calendar.current.date(byAdding: dateComponent, to: currentDate)
        
        guard let NextDay = NextDay else{return []}
        
        return list.filter { WeatherForcast in
            Calendar.current.isDate(NextDay, inSameDayAs: WeatherForcast.dt_txt)
        }
    }
    
    func nextNDayForcast(offset: Int) -> [WeatherForcast]{
        var dateComponent = DateComponents()
        dateComponent.day = offset
        let NextDay = Calendar.current.date(byAdding: dateComponent, to: currentDate)
        
        guard let NextDay = NextDay else{return []}
        
        return list.filter { WeatherForcast in
            Calendar.current.isDate(NextDay, inSameDayAs: WeatherForcast.dt_txt)
        }
    }
}


