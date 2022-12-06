//
//  ContentView.swift
//  SwiftUI Day 70
//
//  Created by Deye Lei on 12/6/22.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @State private var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 0, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 25, longitudeDelta: 25))
    
    @State private var locations:[Location] = []
    
    let emojiMaker = ["🐼","🦊","🐹","🐷","🐿","🐨","🦁"]
    
    @State private var chosedLocation: Location?
    var body: some View {
        ZStack{
            //using map will cause a error of updating state, this is a error of apple
            Map(coordinateRegion: $mapRegion, annotationItems: locations) { location in
                
                
                MapAnnotation(coordinate: location.coordinator) {
                    VStack{
                        Text(emojiMaker[location.emojiMarker])
                            .font(.largeTitle)
                            .padding()
                        Text(location.name)
                            .foregroundColor(.white)
                            .background(LinearGradient(colors: [.yellow, .green], startPoint: .topLeading, endPoint: .bottomTrailing))
                            .foregroundStyle(.ultraThinMaterial)
                            .clipShape(Capsule())
                            .fixedSize()
                    }
                    .onTapGesture {
                        chosedLocation = location
                    }
                }
            }
            .ignoresSafeArea()
            
            Circle()
                .stroke(.pink,style: StrokeStyle(lineWidth: 2))
                .frame(width:10)
            //force it to stay at bottom right corner with spacer()
            
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button {
                        // create a new location
                        let newLocation = Location(name: "New Location", description: "Description", longitude: mapRegion.center.longitude, latitude: mapRegion.center.latitude)
                        //modification
                        
                        locations.append(newLocation)
                    } label: {
                        Image(systemName: "plus")
                    }
                    .padding()
                    .background(.black.opacity(0.75))
                    .foregroundColor(.white)
                    .font(.title)
                    .clipShape(Circle())
                    .padding(.trailing)
                }
            }
        }
        .sheet(item: $chosedLocation) { location in
            DetailLocationView(location: location){
                newLocation in
                if let index = locations.firstIndex(of: location){
                    locations[index] = newLocation
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
