//
//  DailyForecastView.swift
//  WeatherForecast
//
//  Created by Deye Lei on 12/14/22.
//

import Foundation
import SwiftUI

struct DailyForecastView: View {
    
    private let weatherForecasts: [OpenWeather.WeatherForcast]
    @State private var selectedTime: Date = Date.now
    private let city: OpenWeather.City
    var metricUnit:Bool
    
    //find index of selected weatherForcast in the container
    var selectedWeatherForcast: Int{
        return weatherForecasts.firstIndex { forcast in
            forcast.dt_txt == selectedTime
        } ?? 0
    }
    
    let backToSearch: ()->Void
    
    init?(weatherForecasts: [OpenWeather.WeatherForcast], city: OpenWeather.City, metricUnit: Bool, backToSearch: @escaping ()->Void){
        self.weatherForecasts = weatherForecasts
        
        if(weatherForecasts.count == 0){
            return nil
        }
        _selectedTime = State(initialValue: weatherForecasts[0].dt_txt)
        self.city = city
        self.metricUnit = metricUnit
        self.backToSearch = backToSearch
    }
    
    var body: some View {
        NavigationView{
            ScrollView{
                VStack{
                    Group{
                        HStack{
                            Text(city.name) + Text(", ")
                            Text(city.country)
                        }
                        .font(.largeTitle.weight(.bold))
                        .shadow(radius: 5)
                        .padding()
                        
                        Text("\(weatherForecasts[selectedWeatherForcast].main.temp.formatted()) \(metricUnit ? "℃" : "℉")")
                            .font(.largeTitle)
                        
                        HStack{
                            Text(weatherForecasts[selectedWeatherForcast].weather[0].main.description)
                                .font(.title3)
                            Text(selectedTime.formatted(date: .omitted, time: .shortened))
                        }
                    }
                    
                    Divider()
                    
                    TempInDayView(weatherForcasts: weatherForecasts, metricUnit: metricUnit){
                        selectedTime = $0
                    }
                    
                    Divider()
                    
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 170))]) {
                        
                        Group{
                            VStack(spacing: 5.0){
                                Text("Max/Min Temp")
                                    .font(.headline)
                                Text("Max: \(weatherForecasts[selectedWeatherForcast].main.temp_max.formatted()) \(metricUnit ? "℃" : "℉")")
                                Text("Min: \(weatherForecasts[selectedWeatherForcast].main.temp_min.formatted()) \(metricUnit ? "℃" : "℉")")
                            }
                            .frame(width:150,height:100)
                            .padding(.bottom)
                            
                            VStack(spacing: 5.0){
                                Text("Sun Rise/Set")
                                    .font(.headline)
                                Text("Rise: \(city.sunriseTime)")
                                Text("Set: \(city.sunsetTime)")
                            }
                            .frame(width:150,height:100)
                            .padding(.bottom)
                            
                            
                            VStack(spacing: 5){
                                Text("Pressure")
                                    .font(.headline)
                                Text("Sea level: \(weatherForecasts[selectedWeatherForcast].main.sea_level) hPa")
                                Text("Gound level: \(weatherForecasts[selectedWeatherForcast].main.grnd_level) hPa")
                            }
                            .frame(width:150,height:100)
                            .padding(.bottom)
                            
                            VStack(spacing: 5){
                                Text("Humidity")
                                    .font(.headline)
                                Text("\(weatherForecasts[selectedWeatherForcast].main.humidity) %")
                                    .font(.largeTitle)
                            }
                            .frame(width:150,height:100)
                            .padding(.bottom)
                            
                            VStack(spacing: 5){
                                Text("Cloud")
                                    .font(.headline)
                                Text("\(weatherForecasts[selectedWeatherForcast].clouds.all) %")
                                    .font(.largeTitle)
                            }
                            .frame(width:150,height:100)
                            
                            VStack(spacing: 5){
                                Text("Wind")
                                    .font(.headline)
                                Text(" \(weatherForecasts[selectedWeatherForcast].wind.speed.formatted()) \(metricUnit ? "meter/second" : "mile/hour")")
                                    .font(.caption)
                                Text("\(weatherForecasts[selectedWeatherForcast].wind.deg) degree")
                                Text("Wind gust:\( weatherForecasts[selectedWeatherForcast].wind.gust.formatted()) \(metricUnit ? "meter/second" : "mile/hour")")
                                    .font(.caption)
                                
                            }
                            .frame(width:150,height:100)
                            .padding(.bottom)
                        }
                        
                        VStack(spacing: 5){
                            Text("Visbility")
                                .font(.headline)
                            Text("\(weatherForecasts[selectedWeatherForcast].visibility) km")
                        }
                        .frame(width:150,height:100)
                        .padding(.bottom)
                        
                        VStack(spacing: 5){
                            Text("Rain")
                                .font(.headline)
                            if(weatherForecasts[selectedWeatherForcast].rain == nil){
                                Text("data unavailable")
                            }
                            else{
                                Text("\(weatherForecasts[selectedWeatherForcast].rain!.threeH.formatted()) mm")
                                Text("Last 3 hours")
                            }
                        }
                        .frame(width:150,height:100)
                        .padding(.bottom)
                        
                        VStack(spacing:5){
                            Text("Snow")
                                .font(.headline)
                            if(weatherForecasts[selectedWeatherForcast].snow == nil){
                                Text("data unavailable")
                            }
                            else{
                                Text("\(weatherForecasts[selectedWeatherForcast].snow!.threeH.formatted()) mm")
                                Text("Last 3 hours")
                            }
                        }
                        .frame(width:150,height:100)
                        .padding(.bottom)
                    }
                    
                }
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .navigationTitle(selectedTime.dayOfWeek)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar{
                    ToolbarItem {
                        Button("Search"){
                            backToSearch()
                        }
                    }
                }
            }
        }
    }
}

struct MyPreviewProvider_Previews: PreviewProvider {
    static var previews: some View {
        DailyForecastView(weatherForecasts: OpenWeather.WeatherForcast.sampleData, city: OpenWeather.City.sampleDate,metricUnit: true, backToSearch: {})
    }
}

