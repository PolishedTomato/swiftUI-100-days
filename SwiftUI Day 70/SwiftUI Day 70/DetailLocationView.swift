//
//  DetailLocationView.swift
//  SwiftUI Day 70
//
//  Created by Deye Lei on 12/6/22.
//

import Foundation
import SwiftUI

struct DetailLocationView: View {
    
    enum LoadingState {
        case loading, loaded, failed
    }
    
    @Environment(\.dismiss) var dismiss
    var location: Location
    
    @State private var name = ""
    @State private var descrition = ""
    
    var onSave: (Location)->Void
    
    @State private var loadingState = LoadingState.loading
    @State private var pages = [Page]()
    
    func fetchWikiData()async{
        let urlString = "https://en.wikipedia.org/w/api.php?ggscoord=\(location.coordinator.latitude)%7C\(location.coordinator.longitude)&action=query&prop=coordinates%7Cpageimages%7Cpageterms&colimit=50&piprop=thumbnail&pithumbsize=500&pilimit=50&wbptterms=description&generator=geosearch&ggsradius=10000&ggslimit=50&format=json"

            
        guard let url = URL(string: urlString) else{
            print("InValid URL \(urlString)")
            return
        }
        
        do{
            let (data, _) = try await URLSession.shared.data(from: url)
            let result = try JSONDecoder().decode(Result.self, from: data)
            
            //dictionary.values return a array of the value without the key
            pages = result.query.pages.values.sorted()
            loadingState = .loaded
        }
        catch{
            loadingState = .failed
        }
    }
    
    
    var body: some View {
        NavigationView {
            Form{
                Section("Descrition"){
                    TextField("Enter the name", text: $name)
                    TextField("Enter the description", text:$descrition)
                }
                
                Section("Nearby…") {
                    switch loadingState {
                    case .loaded:
                        ForEach(pages, id: \.pageid) { page in
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
            .task{
                await fetchWikiData()
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


