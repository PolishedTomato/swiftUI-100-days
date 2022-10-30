//
//  MissionView.swift
//  MoonShot
//
//  Created by Deye Lei on 10/30/22.
//

import SwiftUI
import Foundation

struct MissionView: View {
    
    init(mission: Mission, astronauts: [String: Astronaut]){
        self.mission = mission
        
        self.crew = self.mission.crew.map{ member in
            if let astronaut = astronauts[member.name]{
                return CrewMember(role: member.role, astronaut: astronaut)
            }
            else{
                fatalError("Error, missing \(member.name)")
            }
        }
    }
    
    let mission: Mission
    let crew: [CrewMember]
    
    var launchDate: String {
        if mission.launchDate == nil{
            return "N/A"
        }
        
        return mission.launchDate!.formatted(date: .abbreviated, time: .omitted)
    }
    var body: some View {
        NavigationView{
            GeometryReader{
                geo in ScrollView{
                    VStack{
                        Image(mission.image)
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: geo.size.width * 0.6)
                        Text("Launch Date: \(launchDate)")
                            .font(.subheadline)
                            
                        VStack(alignment: .leading){
                            Text("Mission highlights")
                                .font(.title.bold())
                                .padding(.bottom, 5)
                            
                            MyDivier()
                            
                            Text("\(mission.description)")
                            
                            MyDivier()
                            
                            Text("Crew")
                                .font(.title.bold())
                                .padding(.bottom, 5)
                        }
                        .padding(.horizontal)
                        
                        CrewMemberView(crew: crew)
                        
                    }
                    .padding(.bottom)
                }
            }
            .navigationTitle(mission.displayName)
            .navigationBarTitleDisplayMode(.inline)
            .background(.darkBackground)
            .preferredColorScheme(.dark)
        }
    }
}


struct MissionView_Previews: PreviewProvider {
    static var astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var missions: [Mission] = Bundle.main.decode("missions.json")
    
    static var mission1 = Mission(id: 1, launchDate: nil, crew: [Mission.CrewRole(name: "Dude1", role: "Do nothing")], description: "smaple data ")
    
    static var previews: some View {
        MissionView(mission: missions[0], astronauts: astronauts)
    }
}
