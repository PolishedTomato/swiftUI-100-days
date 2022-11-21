//
//  ContentView.swift
//  SwiftUI Day 60
//
//  Created by Deye Lei on 11/18/22.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)]) var users : FetchedResults<CachedUser>
    //@State var users:[user] = []
    
    
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
    
    //save decoded data from serve to core data
    func saveData(Us: [user]) async {
        await MainActor.run{
            for u in Us{
                let newUser = CachedUser(context: moc)
                newUser.id = u.id
                newUser.name = u.name
                newUser.age = Int16(u.age)
                newUser.isActive = u.isActive
                newUser.company = u.company
                newUser.email = u.email
                newUser.address = u.address
                newUser.about = u.about
                newUser.registered = u.registered
                
                if moc.hasChanges{
                    try? moc.save()
                }
                //many to one, tag to user
                for t in u.tags{
                    let tag = Tag(context: moc)
                    tag.tag = t
                    tag.tagOf? = newUser
                }
                if moc.hasChanges{
                    try? moc.save()
                }
                
                
                for f in u.friends{
                    let friend = CachedFriend(context: moc)
                    friend.id = f.id
                    friend.name = f.name
                    friend.friendOf? = newUser
                }
                
                if moc.hasChanges{
                    try? moc.save()
                }
                /*
                do{
                    try moc.save()
                }
                catch{
                    print(error.localizedDescription)
                    print("moc save failed")
                    fatalError()
                }*/
            }
        }
    }
    
    var body: some View {
        NavigationView{
            List{
                ForEach(users, id: \.self) { user in
                    NavigationLink {
                        DetailView(user: user, users: users)
                    } label: {
                        HStack{
                            Text(user.wrappedName)
                                .padding()
                            Spacer()
                            Text(user.wrappedCompany)
                                .padding()
                        }
                    }
                }
            }
            .onAppear{
                Task{
                    //get data from server
                    await saveData(Us: fetchData())
                    print("onApear once")
                }
            }
        }
    }
}


