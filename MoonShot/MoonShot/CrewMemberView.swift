//
//  CrewMemberView.swift
//  MoonShot
//
//  Created by Deye Lei on 10/30/22.
//

import SwiftUI
import Foundation

struct CrewMemberView: View {
    let crew: [CrewMember]
    
    var body: some View {
        ScrollView(.horizontal,showsIndicators: false){
            HStack(spacing: 20){
                ForEach(crew, id: \.role){ member in
                    NavigationLink {
                        AstronautView(astronaut: member.astronaut)
                    } label: {
                        HStack{
                            Image(member.astronaut.id)
                                .resizable()
                                .frame(width: 104, height: 72)
                                .clipShape(Capsule())
                                .overlay{
                                    Capsule()
                                        .strokeBorder(.white, lineWidth: 1)
                                }
                            VStack(alignment: .leading){
                                Text(member.astronaut.name)
                                    .font(.headline)
                                    .foregroundColor(.white)
                                
                                Text(member.role)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}

struct CrewMemberView_Previews: PreviewProvider {
    static var astronauts:[String: Astronaut] = Bundle.main.decode("astronauts.json")
    static var missions: [Mission] = Bundle.main.decode("missions.json")
    
    static var sampleData: [CrewMember]{
        let res = missions[0].crew.map{
            member in
            if let astronaut = astronauts[member.name]{
                return CrewMember(role: member.role, astronaut: astronaut)
            }
            else{
                fatalError()
            }
        }
        return res
    }
    static var previews: some View {
        CrewMemberView(crew: sampleData)
    }
}
