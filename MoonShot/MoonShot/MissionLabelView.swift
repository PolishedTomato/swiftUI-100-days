//
//  MissionLabelView.swift
//  MoonShot
//
//  Created by Deye Lei on 10/30/22.
//

import SwiftUI
import Foundation

struct MissionLabelView: View {
    let mission : Mission
    let turn: Bool
    var body: some View {
        VStack{
            Image(decorative: mission.image)
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .padding()
            VStack{
                Text(mission.displayName)
                    .font(.headline)
                    .foregroundColor(.white)
                Text(mission.formattedLaunchDate)
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.5))
            }
            .padding(.vertical)
            .frame(maxWidth: .infinity)
            .background(turn ? .pink :.lightBackground)
            
        }
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(.lightBackground)
        )
    }
    
}

struct MissionLabelView_Previews: PreviewProvider {
    static var missions: [Mission] = Bundle.main.decode("missions.json")
    static var previews: some View {
        MissionLabelView(mission: missions[0], turn: false)
    }
}
