//
//  ContentView.swift
//  cupCakeCorner
//
//  Created by Deye Lei on 11/8/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var order = Order()
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Select your cake type", selection: $order.type) {
                        ForEach(Order.types.indices) {
                            Text(Order.types[$0])
                        }
                    }

                    Stepper("Number of cakes: \(order.quantity)", value: $order.quantity, in: 3...20)
                }
                
                Section{
                    Toggle("Special Order", isOn: $order.specialRequestEnabled.animation())
                    
                    Group{
                        Toggle("Add Sprinkles", isOn: $order.addSprinkles)
                        Toggle("Add extra forsting", isOn: $order.extraFrosting)
                    }
                    .disabled(!order.specialRequestEnabled)
                }
                
                Section{
                    NavigationLink {
                        AddressView(order: order)
                    } label: {
                        Text("Delivery Details")
                    }

                }
            }
            .navigationTitle("Cupcake Corner")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
