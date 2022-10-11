//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Deye Lei on 10/10/22.
//

import SwiftUI

struct ContentView: View {
    @State private var showingAlert = false
    var body: some View {
        
        Button("Show Alert") {
            showingAlert = true
        }
        .alert("Important message", isPresented: $showingAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("Please read this.")
        }
        
        
            
        /*ZStack {
            VStack(spacing: 0) {
                Color.red
                Color.blue
            }

            Text("Your content")
                .foregroundStyle(.secondary)
                .padding(50)
                .background(.ultraThinMaterial)
        }
        .ignoresSafeArea()*/
        
        /*
         LinearGradient(gradient: Gradient(colors: [.white,.black]), startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea()
         */
        
        /*
        LinearGradient(gradient: Gradient(stops: [
                Gradient.Stop(color: .white, location: 0.45),
                Gradient.Stop(color: .black, location: 0.55),
                .init(color: .red, location: 0.75)
            ]), startPoint: .top, endPoint: .bottom)
         */
        /*
        RadialGradient(gradient: Gradient(colors: [.blue, .black]), center: .center, startRadius: 20, endRadius: 200)
         */
        /*
        AngularGradient(gradient: Gradient(colors: [.red, .yellow, .green, .blue, .purple, .red]), center: .center)
        */
        VStack {
            Button("Button 1") { }
                .buttonStyle(.borderedProminent)
            Button("Button 2", role: .destructive) { }
                .buttonStyle(.bordered)
            Button("Button 3") { }
                .buttonStyle(.borderedProminent)
            Button("Button 4", role: .destructive) { }
                .buttonStyle(.borderedProminent)
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
