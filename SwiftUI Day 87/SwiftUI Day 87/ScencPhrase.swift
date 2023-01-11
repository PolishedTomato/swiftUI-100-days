//
//  ScencPhrase.swift
//  SwiftUI Day 87
//
//  Created by Deye Lei on 1/11/23.
//

import Foundation
import SwiftUI

struct ScencPhrase: View {
    @Environment(\.scenePhase) var scenePhrase
    var body: some View {
        Text("Hello world")
            .onChange(of: scenePhrase){
                newPhrase in
                if(newPhrase == .active){
                    print("active")
                }
                else if(newPhrase == .inactive){
                    print("inactive")
                }
                else if(newPhrase == .background){
                    print("background")
                }
            }
    }
}

struct ScencPhrase_Previews: PreviewProvider {
    static var previews: some View {
        ScencPhrase()
    }
}
