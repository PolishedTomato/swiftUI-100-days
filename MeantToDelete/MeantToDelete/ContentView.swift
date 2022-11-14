//
//  ContentView.swift
//  MeantToDelete
//
//  Created by Deye Lei on 10/30/22.
//

import SwiftUI

struct ContentView: View {
    @State var content = ["some string", "some sadasd"]
    var body: some View {
        NavigationView{
            List{
                ForEach(content, id: \.self){
                    Text($0)
                }
                .onDelete { indexSet in
                    content.remove(atOffsets: indexSet)
                }
                .listRowBackground(Color.red)
            }
            .listStyle(.inset)
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
