//
//  AddressView.swift
//  cupCakeCorner
//
//  Created by Deye Lei on 11/8/22.
//

import SwiftUI
import Foundation

struct AddressView: View {
    @ObservedObject var order: Order
    
    var hasValidAddress: Bool{
        return order.name.isEmpty && order.streetAddress.isEmpty && order.city.isEmpty && order.zipCode.isEmpty
    }
    
    var body: some View {
        
            Form{
                Section("Address"){
                    TextField("Enter your name", text: $order.name)
                    TextField("Enter your address", text: $order.streetAddress)
                    TextField("Enter your city", text: $order.city)
                    TextField("Entry your zip code", text:$order.zipCode)
                }
                
                Section{
                    NavigationLink {
                        CheckOutView(order: order)
                    } label: {
                        Text("check out")
                    }

                }
                .disabled(hasValidAddress)
            }
            .navigationTitle("Delivery details")
            .navigationBarTitleDisplayMode(.inline)
        
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(order: Order())
    }
}
