//
//  ContentView.swift
//  SwiftUI Day 39
//
//  Created by Deye Lei on 10/28/22.
//

import SwiftUI
struct User: Codable{
    var name: String
    var address: Address
}

struct Address: Codable{
    var street: String
    var city: String
}

struct ContentView: View {
    let layout = [
        GridItem(.adaptive(minimum: 80)),
        GridItem(.fixed(40))
    ]
    var body: some View {
        ScrollView {
            LazyVGrid(columns: layout) {
                ForEach(0..<1000) {
                    Text("Item \($0)")
                }
            }
        }
        VStack {
            Button("Decode JSON") {
                let input = """
                {
                    "name": "Taylor Swift",
                    "address": {
                        "street": "555, Taylor Swift Avenue",
                        "city": "Nashville"
                    }
                }
                """
                let data = Data(input.utf8)
                let decoder = JSONDecoder()
                if let user = try? decoder.decode(User.self, from: data){
                    print(user.address.city)
                }
                // more code to come
            }
            
            GeometryReader{
                geo in Image("dog")
                    .resizable()
                    .scaledToFit()
                    .frame(width:geo.size.width * 0.5)
                    .frame(width:geo.size.width, height: geo.size.height)
                    //.scaledToFit()
            
                }
            
            ScrollView {
                LazyVStack(spacing: 10) {
                    ForEach(0..<100) {
                        Text("Item \($0)")
                            .font(.title)
                    }
                }
                .frame(height: .infinity)
            }
            
            }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
