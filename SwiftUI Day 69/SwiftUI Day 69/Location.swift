//
//  Location.swift
//  SwiftUI Day 69
//
//  Created by Deye Lei on 12/5/22.
//

import MapKit
import Foundation

struct Location: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}
