//
//  ListItem.swift
//  NamingPhoto
//
//  Created by Deye Lei on 12/23/22.
//

import Foundation
import UIKit
import CoreLocation

struct ListItem: Hashable, Codable, Identifiable{
    var id = UUID()
    var name: String
    var savePath : URL
    var latitude: Double
    var longitude: Double
}
