//
//  ContentView.swift
//  WeatherForecast
//
//  Created by Deye Lei on 12/13/22.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        ZStack{
            Color.secondary
                .ignoresSafeArea()
            if(viewModel.openWeather == nil){
                LocationFormView(unit: $viewModel.unit, openWeather: $viewModel.openWeather)
            }
            else{
                TabView {
                    DailyForecastView(weatherForecasts: viewModel.openWeather!.nextNDayForcast(offset: 0), city: viewModel.openWeather!.city, unit: viewModel.unit){
                        viewModel.openWeather = nil
                    }
                        .tabItem{
                            Label(Date.now.nextNDay(offset: 0).dayOfWeek, systemImage: "sparkles" )
                                .accessibilityLabel("\(Date.now.nextNDay(offset: 0).dayOfWeek) tap to change weather detail to specified day")
                        }
                    
                    DailyForecastView(weatherForecasts: viewModel.openWeather!.nextNDayForcast(offset: 1), city: viewModel.openWeather!.city, unit: viewModel.unit){
                        viewModel.openWeather = nil
                    }
                        .tabItem{
                            Label(Date.now.nextNDay(offset: 1).dayOfWeek, systemImage: "sparkles" )
                                .accessibilityLabel("\(Date.now.nextNDay(offset: 1).dayOfWeek) tap to change weather detail to specified day")
                            
                        }
                    
                    DailyForecastView(weatherForecasts: viewModel.openWeather!.nextNDayForcast(offset: 2), city: viewModel.openWeather!.city, unit: viewModel.unit){
                        viewModel.openWeather = nil
                    }
                        .tabItem{
                            Label(Date.now.nextNDay(offset: 2).dayOfWeek, systemImage: "sparkles" )
                                .accessibilityLabel("\(Date.now.nextNDay(offset: 2).dayOfWeek) tap to change weather detail to specified day")
                        }
                    
                    DailyForecastView(weatherForecasts: viewModel.openWeather!.nextNDayForcast(offset: 3), city: viewModel.openWeather!.city, unit: viewModel.unit){
                        viewModel.openWeather = nil
                    }
                        .tabItem{
                            Label(Date.now.nextNDay(offset: 3).dayOfWeek, systemImage: "sparkles" )
                                .accessibilityLabel("\(Date.now.nextNDay(offset: 3).dayOfWeek) tap to change weather detail to specified day")
                            
                        }
                        
                    
                    DailyForecastView(weatherForecasts: viewModel.openWeather!.nextNDayForcast(offset: 4), city: viewModel.openWeather!.city, unit: viewModel.unit){
                        viewModel.openWeather = nil
                    }
                        .tabItem{
                            Label(Date.now.nextNDay(offset: 4).dayOfWeek, systemImage: "sparkles" )
                                .accessibilityLabel("\(Date.now.nextNDay(offset: 4).dayOfWeek) tap to change weather detail to specified day")
                            
                        }
                        
                    
                    DailyForecastView(weatherForecasts: viewModel.openWeather!.nextNDayForcast(offset: 5), city: viewModel.openWeather!.city, unit: viewModel.unit){
                        viewModel.openWeather = nil
                    }
                        .tabItem{
                            Label(Date.now.nextNDay(offset: 5).dayOfWeek, systemImage: "sparkles" )
                                .accessibilityLabel("\(Date.now.nextNDay(offset: 5).dayOfWeek) tap to change weather detail to specified day")
                            
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
