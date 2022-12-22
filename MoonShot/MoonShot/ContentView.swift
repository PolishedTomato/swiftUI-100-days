//
//  ContentView.swift
//  MoonShot
//
//  Created by Deye Lei on 10/28/22.
//

import SwiftUI

struct ContentView: View {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    let layout = [GridItem(.adaptive(minimum: 150))]
    
    @State private var turn = false
    var body: some View {
        NavigationView{
            if(turn == false){
                ScrollView{
                    LazyVGrid(columns: layout) {
                        ForEach(missions) { mission in
                            NavigationLink {
                                MissionView(mission: mission, astronauts: astronauts)
                            } label: {
                                MissionLabelView(mission: mission, turn: turn)
                            }
                            //.padding([.horizontal, .bottom])
                        }
                    }
                    .padding([.horizontal, .bottom])
                }
                .navigationTitle("MoonShot")
                .background(.darkBackground)
                .preferredColorScheme(.dark)
                .toolbar{
                    ToolbarItem {
                        Button("Tap to switch"){
                            turn.toggle()
                        }
                    }
                }
            }
            else{
                List {
                    ForEach(missions){
                        mission in
                        NavigationLink {
                            MissionView(mission: mission, astronauts: astronauts)
                        } label: {
                            MissionLabelView(mission: mission, turn: turn)
                        }
                        .listRowBackground(Color.white)
                    }
                }
                .listStyle(.sidebar)
                .navigationTitle("MoonShot")
                .preferredColorScheme(.dark)
                .toolbar{
                    ToolbarItem {
                        Button("Tap to switch"){
                            turn.toggle()
                        }
                    }
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
