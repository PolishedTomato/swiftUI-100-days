//
//  Bundle-Decodable.swift
//  MoonShot
//
//  Created by Deye Lei on 10/28/22.
//

import Foundation

extension Bundle{
    func decode<T: Codable>(_ filename: String) -> T{
        let formatter = DateFormatter()
        formatter.dateFormat = "y-MM-dd"
        
        guard let url = self.url(forResource: filename, withExtension: nil)
        else{
            fatalError("\(filename) didn't load")
        }
        
        guard let data = try? Data(contentsOf: url)
        else{
            fatalError("can't get \(filename) data")
        }
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(formatter)
        guard let loaded = try? decoder.decode(T.self, from: data)
        else{
            fatalError("\(filename) didn't decode")
        }
        
        return loaded
    }
}
