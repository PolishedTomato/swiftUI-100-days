//
//  MapView.swift
//  HotProspects
//
//  Created by Deye Lei on 1/9/23.
//

import Foundation
import MapKit
import SwiftUI

struct MapView: View {
    @State var Region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 40.7520, longitude: -73.9946), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
    @EnvironmentObject var prospects: Prospects
    
    var body: some View {
        Map(coordinateRegion: $Region, annotationItems: prospects.people) { person in
            MapMarker(coordinate: CLLocationCoordinate2DMake(person.lat, person.lon))
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
