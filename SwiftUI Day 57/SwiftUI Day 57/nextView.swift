//
//  nextView.swift
//  SwiftUI Day 57
//
//  Created by Deye Lei on 11/16/22.
//

import SwiftUI
import Foundation

struct nextView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [], predicate: NSPredicate(format: "director BEGINSWITH %@", "m")) var datas: FetchedResults<Movie>
    
    var body: some View {
        VStack{
            ForEach(datas, id: \.self){ data in
                Text(data.wrappedTitle)
            }
            
            Button("Add some data"){
                let movie1 = Movie(context: moc)
                movie1.title = "Three body"
                movie1.director = "A"
                
                let movie2 = Movie(context: moc)
                movie2.title = "one body"
                movie2.director = "B"
                
                let movie3 = Movie(context: moc)
                movie3.title = "two body"
                movie3.director = "C"
                
                try? moc.save()
            }
            
            NavigationLink {
                nextView1()
            } label: {
                Text("Tap to next")
            }

        }
    }
}

