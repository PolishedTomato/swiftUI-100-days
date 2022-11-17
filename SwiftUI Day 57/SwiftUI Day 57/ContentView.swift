//
//  ContentView.swift
//  SwiftUI Day 57
//
//  Created by Deye Lei on 11/16/22.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var movies: FetchedResults<Movie>
    
    var body: some View {
        NavigationView{
            VStack {
                ForEach(movies, id: \.self){
                    Text($0.title ?? "unkonwed title")
                }
                
                Button("Add"){
                    let movie = Movie(context: moc)
                    movie.title = "three body"
                    movie.director = "me"
                }
                
                Button("Save"){
                    do{
                        try moc.save()
                    }
                    catch{
                        print(error.localizedDescription)
                    }
                }
                NavigationLink {
                    nextView()
                } label: {
                    Text("Tap to next view")
                }

            }
        }
    }
}

