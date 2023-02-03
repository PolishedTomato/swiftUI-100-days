//
//  FileManager.swift
//  SnowSeeker
//
//  Created by Deye Lei on 2/2/23.
//

import Foundation

extension FileManager{
    static var savePath: URL{
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appending(path: "saveLocation")
    }
}
