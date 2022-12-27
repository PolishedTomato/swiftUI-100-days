//
//  DetailPhotoView.swift
//  NamingPhoto
//
//  Created by Deye Lei on 12/23/22.
//

import Foundation
import SwiftUI
import MapKit

struct DetailPhotoView: View {
    let item: ListItem
    
    var container: [ListItem]{
        return [item]
    }
    
    var displayImage:Image?{
        guard let data = try? Data(contentsOf: item.savePath) else{return nil}
        guard let uiImage = UIImage(data: data) else {return nil}
        return Image(uiImage: uiImage)
    }
    
    @State var center = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 0, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10))
    
    init(item: ListItem){
        self.item = item
        _center = State(initialValue: MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: item.latitude, longitude: item.longitude), span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)))
    }
    
    var body: some View {
        NavigationView {
            VStack{
                Map(coordinateRegion: $center, annotationItems: container) { item in
                    MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: item.latitude, longitude: item.longitude)) {
                        VStack{
                            displayImage?
                                .resizable()
                                .scaledToFit()
                                .cornerRadius(15)
                                .frame(width: 100, height:100)
                            Text("\(item.name)")
                        }
                    }
                }
            }
            
            .navigationTitle(item.name)
        }
    }
}


