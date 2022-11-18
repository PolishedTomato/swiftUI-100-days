//
//  ContentView.swift
//  SwiftUI Day 60
//
//  Created by Deye Lei on 11/18/22.
//

import SwiftUI

struct ContentView: View {
    @State var users:[user] = []
    
    
    func fetchData()async ->[user]{
        
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")
        else{
            print("invaild url")
            return []
        }
        
        do{
            let (data, _) = try await URLSession.shared.data(from: url)
            
            //register data field is in this format
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            guard let x = try? decoder.decode([user].self, from: data)
            else{
                fatalError()
            }
            return x
        }
        catch{
            print(error.localizedDescription)
            fatalError()
        }
    }
    
    var body: some View {
        NavigationView{
            List{
                ForEach(users) { user in
                    NavigationLink {
                        DetailView(user: user, users: users)
                    } label: {
                        HStack{
                            Text(user.name)
                                .padding()
                            Spacer()
                            Text(user.company)
                                .padding()
                        }
                    }
                }
            }
            .onAppear{
                Task{
                    //get data from server
                    users = await fetchData()
                }
            }
        }
    }
}


