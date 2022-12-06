//
//  DetailLocationView.swift
//  SwiftUI Day 70
//
//  Created by Deye Lei on 12/6/22.
//

import Foundation
import SwiftUI

struct DetailLocationView: View {
    @Environment(\.dismiss) var dismiss
    var location: Location
    
    @State private var name = ""
    @State private var descrition = ""
    
    var onSave: (Location)->Void
    
    var body: some View {
        NavigationView {
            Form{
                Section("Descrition"){
                    TextField("Enter the name", text: $name)
                    TextField("Enter the description", text:$descrition)
                }
                
                
            }
            .navigationTitle(location.name)
            .toolbar {
                ToolbarItem(placement: .confirmationAction){
                    Button("Save"){
                        //struct is immutable, therefore we can't change location, but create a newLocation for this task
                        //every time we change a struct we created, swiftUI create a copy of it
                        var newLocation = location
                        newLocation.id = UUID()
                        newLocation.name = name
                        newLocation.description = descrition
                        onSave(newLocation)
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .cancellationAction) {
                    Button("cancel"){
                        dismiss()
                    }
                }
            }
        }
    }
    
    init(location:Location, onSave: @escaping (Location)->Void){
        _name = State(initialValue: location.name)
        _descrition = State(initialValue: location.description)
        
        self.onSave = onSave
        self.location = location
    }
}


