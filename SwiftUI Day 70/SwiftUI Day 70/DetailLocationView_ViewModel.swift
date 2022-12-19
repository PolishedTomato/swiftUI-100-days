//
//  DetailLocationView_ViewModel.swift
//  Bucket List
//
//  Created by Deye Lei on 12/19/22.
//

import Foundation

extension DetailLocationView{
    @MainActor class ViewModel: ObservableObject{
        
        init(newLocation: Location){
            self.location = newLocation
        }
        
        enum LoadingState {
            case loading, loaded, failed
        }
        
        var location: Location
        
        @Published var name = ""
        @Published var descrition = ""
        
        @Published var loadingState = LoadingState.loading
        @Published var pages = [Page]()
        
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
    }
}
