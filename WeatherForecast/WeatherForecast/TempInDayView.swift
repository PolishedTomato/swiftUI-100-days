//
//  TempInDayView.swift
//  WeatherForecast
//
//  Created by Deye Lei on 12/15/22.
//

import Foundation
import SwiftUI

struct TempInDayView: View {
    let weatherForcasts: [OpenWeather.WeatherForcast]
    let metricUnit:Bool
    let onTapAction: (Date)->Void
    
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false){
            HStack{
                ForEach(weatherForcasts, id: \.dt_txt) { weatherForcast in
                    TempAtTimeView(time: weatherForcast.dt_txt, temp: weatherForcast.main.temp, metricUnit: metricUnit)
                        .onTapGesture {
                            onTapAction(weatherForcast.dt_txt)
                        }
                }
            }
        }
    }
    
    init(weatherForcasts: [OpenWeather.WeatherForcast],metricUnit: Bool,onTapAction: @escaping (Date)->Void){
        self.weatherForcasts = weatherForcasts
        self.metricUnit = metricUnit
        self.onTapAction = onTapAction
    }
}

struct TempInDayView_Previews: PreviewProvider {
    static var previews: some View {
        TempInDayView(weatherForcasts: OpenWeather.WeatherForcast.sampleData, metricUnit: true, onTapAction: {$0})
    }
}
