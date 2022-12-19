//
//  ContentView-ViewModel.swift
//  Bucket List
//
//  Created by Deye Lei on 12/12/22.
//

import Foundation
import MapKit
import LocalAuthentication


extension ContentView{
    @MainActor class ViewModel: ObservableObject{
        @Published var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 25, longitudeDelta: 25))
        
        @Published private(set) var locations:[Location]
        
        let emojiMaker = ["🐼","🦊","🐹","🐷","🐿","🐨","🦁"]
        
        @Published var chosedLocation: Location?
        
        
        let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedPlaces")

        @Published var isUnlocked = true
        @Published var bioAuthenticationFail = false
        func addLocation(){
            let newLocation = Location(name: "New Location", description: "Description", longitude: mapRegion.center.longitude, latitude: mapRegion.center.latitude)
            //modification
            
            locations.append(newLocation)
        }
        
        //update the location
        func update(newLocation: Location){
            guard let selectedLocation = chosedLocation else{return}
            
            if let index = locations.firstIndex(of: selectedLocation){
                locations[index] = newLocation
            }
        }
        
        func authorize(){
            let context = LAContext()
            var error: NSError?
            
            if(context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error)){
                let reason = "We need you to verify yourself"
                
                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authticationError in
                    
                    if success{
                        self.isUnlocked = true
                    }else{
                        self.bioAuthenticationFail = true
                    }
                }
            }
            else{
                //no biometric
            }
        }
        
        func save(){
            do{
                let data = try JSONEncoder().encode(locations)
                try data.write(to: savePath, options: [.atomic, .completeFileProtection])
            }
            catch{
                print("Failed to save")
            }
        }
        
        //retreive data
        init(){
            do{
                let data = try Data(contentsOf: savePath)
                locations = try JSONDecoder().decode([Location].self, from: data)
            }
            catch{
                locations = []
            }
        }
    }
}
