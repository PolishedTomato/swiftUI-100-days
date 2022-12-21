//
//  FileManager-DocumentsDirectory.swift
//  Bucket List
//
//  Created by Deye Lei on 12/12/22.
//

import Foundation

extension FileManager{
    static var documentsDirectory: URL{
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
