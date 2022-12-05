//
//  ContentView.swift
//  SwiftUI Day 69
//
//  Created by Deye Lei on 12/5/22.
//
import MapKit
import SwiftUI
import LocalAuthentication

struct ContentView: View {
    //the MK stand for mapkit, Span means the interval
    @State private var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.5, longitude: -0.12), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
    
    let locations = [
        Location(name: "Buckingham Palace", coordinate: CLLocationCoordinate2D(latitude: 51.501, longitude: -0.141)),
        Location(name: "Tower of London", coordinate: CLLocationCoordinate2D(latitude: 51.508, longitude: -0.076))
    ]
    
    @State private var circleHeight = 40.0
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?

        // check whether biometric authentication is possible
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            // it's possible, so go ahead and use it
            let reason = "We need to unlock your data."

            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                // authentication has now completed
                if success {
                    // authenticated successfully
                    isUnlocked = true
                } else {
                    // there was a problem
                }
            }
        } else {
            // no biometrics
        }
    }
    
    @State private var isUnlocked = false
    var body: some View {
        VStack {
            //creating a map with custom view on marker rather then ballon by using MapMaker(ClCorrdinator:) as content of the closure
            /*
            Map(coordinateRegion: $mapRegion, annotationItems: locations) { location in
                MapMarker(coordinate: location.coordinate)
            }*/
            
            
            if isUnlocked{
                Text("unlocked")
            }else{
                Text("unable to unlock")
            }
            
        }
        .padding()
        .onAppear(perform: authenticate)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
