//
//  Date.swift
//  WeatherForecast
//
//  Created by Deye Lei on 12/14/22.
//

import Foundation

extension Date{
    var dayOfWeek: String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        
        return dateFormatter.string(from: self).capitalized
    }
    
    func nextNDay(offset: Int)->Date{
        var dateComponent = DateComponents()
        dateComponent.day = offset
        
        return Calendar.current.date(byAdding: dateComponent, to: Date.now) ?? Date.now
    }
}
