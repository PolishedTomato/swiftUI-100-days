//
//  FileManager.swift
//  SwiftUI Day 95
//
//  Created by Deye Lei on 1/26/23.
//

import Foundation

extension FileManager{
    static var SavePath: URL{
        return self.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appending(path: "savePath")
    }
}
