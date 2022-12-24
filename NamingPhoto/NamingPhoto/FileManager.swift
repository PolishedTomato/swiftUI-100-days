//
//  FileManager.swift
//  NamingPhoto
//
//  Created by Deye Lei on 12/23/22.
//

import Foundation

extension FileManager{
    static var savePath:URL{
        var paths = self.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    static func savePath(offset: Int)-> URL{
        savePath.appending(component: "\(offset)")
    }
}
