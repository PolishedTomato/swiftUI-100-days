//
//  DetailView.swift
//  SwiftUI Day 60
//
//  Created by Deye Lei on 11/18/22.
//

import SwiftUI
import Foundation

struct DetailView: View {
    let user: user
    
    let users: [user]
    
    //find friend's info in users
    var friends: [user]{
        user.friends.map{ friend in
            for u in users{
                if friend.id == u.id{
                    return u
                }
            }
            return users[0]
        }
    }
    
    var body: some View {
        List{
            VStack{
                Text("\(user.age) years ago")
                Spacer()
                Text("email: "+user.email)
            }
            
            Section("About"){
                Text(user.about)
            }
            
            ScrollView(.horizontal){
                HStack{
                    ForEach(friends){ friend in
                        NavigationLink{
                            FriendDetalView(friend: friend)
                        } label:{
                            Text(friend.name)
                                .overlay{
                                    Capsule()
                                        .stroke(.gray, style: StrokeStyle(lineWidth: 1))
                                }
                        }
                    }
                }
            }
        }
        .navigationTitle(user.name)
    }
}

