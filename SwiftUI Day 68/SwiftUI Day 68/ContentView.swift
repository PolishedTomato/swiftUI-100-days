//
//  ContentView.swift
//  SwiftUI Day 68
//
//  Created by Deye Lei on 12/2/22.
//

import SwiftUI

func getDocumentsDirectory() -> URL {
    // find all possible documents directories for this user
    // second parameter specify which domain to search(user's home directory this case)
    // first parameter tell what kind of file to search
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    
    // just send back the first one, which ought to be the only one
    
    return paths[0]
}

struct ContentView: View {
    var body: some View {
        Text("Hello World")
            .onTapGesture {
                let str = "Test Message"
                FileManager.writeAndSendBack(content: str, pathComponent: "message.txt")
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
