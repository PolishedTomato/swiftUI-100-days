//
//  FileManager.swift
//  WeatherForecast
//
//  Created by Deye Lei on 12/13/22.
//

import Foundation

extension FileManager{
    static var savePath: URL{
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        return paths[0]
    }
}
