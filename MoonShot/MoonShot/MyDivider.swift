//
//  MyDivider.swift
//  MoonShot
//
//  Created by Deye Lei on 10/30/22.
//

import SwiftUI
import Foundation

struct MyDivier: View {
    var body: some View {
        Rectangle()
            .frame(height: 2)
            .background(.lightBackground)
            .padding(.vertical)
    }
}

struct MyDivier_Previews: PreviewProvider {
    static var previews: some View {
        MyDivier()
    }
}
