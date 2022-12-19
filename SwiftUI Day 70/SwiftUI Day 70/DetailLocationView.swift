//
//  DetailLocationView.swift
//  SwiftUI Day 70
//
//  Created by Deye Lei on 12/6/22.
//

import Foundation
import SwiftUI

struct DetailLocationView: View {
    @StateObject var viewModel = ViewModel(newLocation: Location(name: "default", description: "none", longitude: 0.1, latitude: 0.1))
    
    @Environment(\.dismiss) var dismiss
    
    var onSave: (Location)->Void
    
    var body: some View {
        NavigationView {
            Form{
                Section("Descrition"){
                    TextField("Enter the name", text: $viewModel.name)
                    TextField("Enter the description", text:$viewModel.descrition)
                }
                
                Section("Nearby…") {
                    switch viewModel.loadingState {
                    case .loaded:
                        ForEach(viewModel.pages, id: \.pageid) { page in
                            Text(page.title)
                                .font(.headline)
                            + Text(": ") +
                            Text(page.description)
                                .italic()
                        }
                    case .loading:
                        Text("Loading…")
                    case .failed:
                        Text("Please try again later.")
                    }
                }
            }
            .navigationTitle(viewModel.location.name)
            .toolbar {
                ToolbarItem(placement: .confirmationAction){
                    Button("Save"){
                        //struct is immutable, therefore we can't change location, but create a newLocation for this task
                        //every time we change a struct we created, swiftUI create a copy of it
                        var newLocation = viewModel.location
                        newLocation.id = UUID()
                        newLocation.name = viewModel.name
                        newLocation.description = viewModel.descrition
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
            .task{
                await viewModel.fetchWikiData()
            }
        }
    }
    
    init(location:Location, onSave: @escaping (Location)->Void){
        self.onSave = onSave
        
        _viewModel = StateObject(wrappedValue: ViewModel(newLocation: location))
        viewModel.name = location.name
        viewModel.descrition = location.description
        
    }
}


