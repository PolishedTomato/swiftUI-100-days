//
//  ContentView.swift
//  SwiftUI Day 25
//
//  Created by Deye Lei on 10/16/22.
//

import SwiftUI

struct ContentView: View {
    @State private var sleepHour = 0.0
    @State private var curDay = Date.now
    var body: some View {
        VStack {
            Stepper("your \(sleepHour.formatted())", value: $sleepHour,in: -2...12, step: 2.0)
            DatePicker("", selection: $curDay, in: Date.now..., displayedComponents: .hourAndMinute)
                .labelsHidden()
            Text("\(curDay)")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
