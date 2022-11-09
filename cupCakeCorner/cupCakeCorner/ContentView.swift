//
//  ContentView.swift
//  cupCakeCorner
//
//  Created by Deye Lei on 11/8/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var order = OrderWrapper()
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Select your cake type", selection: $order.order.type) {
                        ForEach(Order_Copy.types.indices) {
                            Text(Order_Copy.types[$0])
                        }
                    }

                    Stepper("Number of cakes: \(order.order.quantity)", value: $order.order.quantity, in: 3...20)
                }
                
                Section{
                    Toggle("Special Order", isOn: $order.order.specialRequestEnabled.animation())
                    
                    Group{
                        Toggle("Add Sprinkles", isOn: $order.order.addSprinkles)
                        Toggle("Add extra forsting", isOn: $order.order.extraFrosting)
                    }
                    .disabled(!order.order.specialRequestEnabled)
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
