//
//  FileManager.swift
//  SwiftUI Day 68
//
//  Created by Deye Lei on 12/2/22.
//

import Foundation

extension FileManager{
    static func writeAndSendBack(content: String, pathComponent: String){
        var url = self.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        url = url.appendingPathComponent(pathComponent)
        
        do{
            try content.write(to: url, atomically: true, encoding: .utf8)
            let result = try String(contentsOf: url)
            print(result)
        }
        catch{
            print(error.localizedDescription)
        }
    }
}
