//
//  TempAtTimeView.swift
//  WeatherForecast
//
//  Created by Deye Lei on 12/15/22.
//

import Foundation
import SwiftUI

struct TempAtTimeView: View {
    let time : Date
    let temp : Double
    let unit:Units
    
    var body: some View {
        VStack(spacing:5){
            Text("\(temp.formatted()) \(unit == .metric ? "℃" :"℉")")
                .font(.title3.bold())
            Text(time.formatted(date: .omitted, time: .shortened))
        }
        .frame(width: 100, height: 100)
        .accessibilityElement(children: .combine)
    }
}

struct TempAtTimeView_Previews: PreviewProvider {
    static var previews: some View {
        TempAtTimeView(time: Date.now, temp: 12, unit: .imperial)
    }
}
