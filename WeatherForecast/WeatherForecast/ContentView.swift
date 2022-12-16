//
//  ContentView.swift
//  WeatherForecast
//
//  Created by Deye Lei on 12/13/22.
//

import SwiftUI

struct ContentView: View {
    
    @State var openWeather:OpenWeather? = nil
    @State var metricUnit = true;
    
    var body: some View {
        ZStack{
            Color.secondary
                .ignoresSafeArea()
            if(openWeather == nil){
                LocationFormView(metricUnit: $metricUnit, openWeather: $openWeather)
            }
            else{
                TabView {
                    DailyForecastView(weatherForecasts: openWeather!.nextNDayForcast(offset: 0), city: openWeather!.city, metricUnit: metricUnit){
                        openWeather = nil
                    }
                        .tabItem{
                            Label(Date.now.nextNDay(offset: 0).dayOfWeek, systemImage: "" )
                        }
                    
                    DailyForecastView(weatherForecasts: openWeather!.nextNDayForcast(offset: 1), city: openWeather!.city, metricUnit: metricUnit){
                        openWeather = nil
                    }
                        .tabItem{
                            Label(Date.now.nextNDay(offset: 1).dayOfWeek, systemImage: "" )
                            
                        }
                    
                    DailyForecastView(weatherForecasts: openWeather!.nextNDayForcast(offset: 2), city: openWeather!.city, metricUnit: metricUnit){
                        openWeather = nil
                    }
                        .tabItem{
                            Label(Date.now.nextNDay(offset: 2).dayOfWeek, systemImage: "" )
                        }
                    
                    DailyForecastView(weatherForecasts: openWeather!.nextNDayForcast(offset: 3), city: openWeather!.city, metricUnit: metricUnit){
                        openWeather = nil
                    }
                        .tabItem{
                            Label(Date.now.nextNDay(offset: 3).dayOfWeek, systemImage: "" )
                            
                        }
                    
                    DailyForecastView(weatherForecasts: openWeather!.nextNDayForcast(offset: 4), city: openWeather!.city, metricUnit: metricUnit){
                        openWeather = nil
                    }
                        .tabItem{
                            Label(Date.now.nextNDay(offset: 4).dayOfWeek, systemImage: "" )
                            
                        }
                    
                    DailyForecastView(weatherForecasts: openWeather!.nextNDayForcast(offset: 5), city: openWeather!.city, metricUnit: metricUnit){
                        openWeather = nil
                    }
                        .tabItem{
                            Label(Date.now.nextNDay(offset: 5).dayOfWeek, systemImage: "" )
                            
                        }
                     
                }
                
            }
            
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
