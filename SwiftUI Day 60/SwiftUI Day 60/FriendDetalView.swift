//
//  FriendDetalView.swift
//  SwiftUI Day 60
//
//  Created by Deye Lei on 11/18/22.
//

import SwiftUI
import Foundation

struct FriendDetalView: View {
    let friend: CachedUser
    var body: some View {
        List{
            VStack{
                Text("\(friend.age) years ago")
                Spacer()
                Text("email: "+friend.wrappedEmail)
            }
            
            Section("About"){
                Text(friend.wrappedAbout)
            }
            
            ScrollView(.horizontal){
                HStack{
                    ForEach(friend.myFriends){ friend in
                        Text(friend.wrappedName)

                            
                    }
                }
            }
        }
        .navigationTitle(friend.wrappedName)
    }
}

