//
//  ContentView.swift
//  SwiftUI Day 49
//
//  Created by Deye Lei on 11/7/22.
//

import SwiftUI

class User: Codable, ObservableObject{
    enum CodingKeys: CodingKey{
        case name
    }
    
    required init(from decoder: Decoder) throws {
        //ask the decoder to return a data representation with keys match to the key we provided(name in this case), could throw for provided key may not exist.
        let container = try decoder.container(keyedBy: CodingKeys.self)
        //then use the container with matching key to decode to specific type
        name = try container.decode(String.self, forKey: .name)
    }
    
    func encode(to encoder: Encoder) throws {
        //create a containter which base on provided keys
        var container = encoder.container(keyedBy: CodingKeys.self)
        //write value into container with value and key pair
        try container.encode(name, forKey: .name)
    }
    @Published var name: String
}

struct ContentView: View {
    @State private var results = [Result]()

    
    func loadData () async{
        guard let url = URL(string: "https://itunes.apple.com/search?term=taylor+swift&entity=song") else {
            print("Invalid URL")
            return
        }
        
        do {
            //use data(from:) of URLSession class to return a tuple of (data, metaData)
            let (data, _) = try await URLSession.shared.data(from: url)

            if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
                results = decodedResponse.results
            }
            // more code to come
        } catch {
            print("Invalid data")
        }
        
        
        
    }
    var body: some View {
        NavigationView{
            VStack{
                List(results, id: \.trackId) { item in
                    VStack(alignment: .leading) {
                        Text(item.trackName)
                            .font(.headline)
                        Text(item.collectionName)
                    }
                }
                .task{
                    await loadData()
                }
                
                NavigationLink{
                    VStack{
                        AsyncImage(url: URL(string: "https://hws.dev/img/logo.png"), scale: 3)
                        
                        AsyncImage(url: URL(string: "https://hws.dev/img/logo.png")) { image in
                            image
                                .resizable()
                                .scaledToFit()
                        } placeholder: {
                            Color.red
                        }
                        .frame(width: 200, height: 200)
                        
                        AsyncImage(url: URL(string: "https://hws.dev/img/log.png")) { phase in
                            if let image = phase.image {
                                image
                                    .resizable()
                                    .scaledToFit()
                            } else if phase.error != nil {
                                Text("There was an error loading the image.")
                            } else {
                                ProgressView()
                            }
                        }
                        .frame(width: 200, height: 200)
                        
                    }
                } label:{
                    Text("Tap")
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
