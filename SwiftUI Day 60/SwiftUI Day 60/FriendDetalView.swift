//
//  FriendDetalView.swift
//  SwiftUI Day 60
//
//  Created by Deye Lei on 11/18/22.
//

import SwiftUI
import Foundation

struct FriendDetalView: View {
    let friend: user
    var body: some View {
        List{
            VStack{
                Text("\(friend.age) years ago")
                Spacer()
                Text("email: "+friend.email)
            }
            
            Section("About"){
                Text(friend.about)
            }
            
            ScrollView(.horizontal){
                HStack{
                    ForEach(friend.friends){ friend in
                        Text(friend.name)
                            .overlay{
                                Capsule()
                                    .stroke(.gray, style: StrokeStyle(lineWidth: 1))
                            }
                            
                    }
                }
            }
        }
        .navigationTitle(friend.name)
    }
}

