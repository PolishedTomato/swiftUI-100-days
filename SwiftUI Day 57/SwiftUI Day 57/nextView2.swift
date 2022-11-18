//
//  nextView2.swift
//  SwiftUI Day 57
//
//  Created by Deye Lei on 11/17/22.
//

import SwiftUI
import Foundation

enum predicates{
    case equal, beginswith, smaller, bigger
}

struct nextView2: View {
    @State var filter1 = "director"
    @State var filter2 = "me"
    let predicates = ["==", "<", ">","BEGINSWITH"]
    @State var p = 0
    
    
    //challenge three complete!
    let mySortDescriptor = [SortDescriptor<Movie>(\.title)]
    
    var body: some View {
        NavigationLink{
            DynamicFilter(filter1: filter1, filter2: filter2, predicate: .smaller, MysortDescriptors: mySortDescriptor){
                (movie : Movie) in
                
                    Text(movie.wrappedTitle)
                    Text(movie.director ?? "Unkown")
                
            }
        } label:{
            Text("Tap to go dynamic fliter")
        }
        
        TextField("Enter filter1, ex: director", text: $filter1)
        
        TextField("enter filter2, ex: me", text: $filter2)
        
        Button("Tap to randomize predicate"){
            p = Int.random(in: 0...4)
        }
    }
}


