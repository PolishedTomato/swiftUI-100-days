//
//  FileManager.swift
//  HotProspects
//
//  Created by Deye Lei on 1/6/23.
//

import Foundation

extension FileManager{
    static var documentDirectory: URL{
        let path = self.default.urls(for: .documentDirectory, in: .userDomainMask)
        return path[0]
    }
    
    static var savedPath: URL{
        return documentDirectory.appending(path: "saveLocation")
    }
}
