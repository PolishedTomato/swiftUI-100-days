//
//  ContentView_ViewModel.swift
//  WeatherForecast
//
//  Created by Deye Lei on 12/21/22.
//

import Foundation

extension ContentView{
    @MainActor class ViewModel:ObservableObject{
        @Published var openWeather:OpenWeather? = nil
        @Published var unit: Units = .imperial;
    }
}

//matric for celsius, imperial for fahrenheit
enum Units: String, CaseIterable, Identifiable{
    case metric, imperial
    var id: Self {
        return self
    }
}
