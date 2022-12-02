//
//  ContentView.swift
//  MeantToDelete
//
//  Created by Deye Lei on 10/30/22.
//

import SwiftUI

struct ContentView: View {
    static var content = ["some string", "some sadasd"]
    @State var myselect = content[0]
    var body: some View {
        VStack{
            Picker("picker something", selection: $myselect){
                ForEach(ContentView.content, id: \.self) { s in
                    Text(s)
                }
            }
            Text(myselect)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
