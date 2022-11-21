//
//  DetailView.swift
//  SwiftUI Day 60
//
//  Created by Deye Lei on 11/18/22.
//

import SwiftUI
import Foundation

struct DetailView: View {
    let user: CachedUser
    
    let users: FetchedResults<CachedUser>
    
    //find friend's info in users
    var friends: [CachedUser]{
        user.myFriends.map{ friend in
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
                Text("email: "+user.wrappedEmail)
            }
            
            Section("About"){
                Text(user.wrappedAbout)
            }
            
            if(friends.isEmpty){
                Text("Friend is empty")
            }
            
            ScrollView(.horizontal){
                HStack{
                    ForEach(friends){ friend in
                        NavigationLink{
                            FriendDetalView(friend: friend)
                        } label:{
                            Text(friend.wrappedName)
                        }
                    }
                }
            }
        }
        .navigationTitle(user.wrappedName)
    }
}

