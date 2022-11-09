//
//  AddressView.swift
//  cupCakeCorner
//
//  Created by Deye Lei on 11/8/22.
//

import SwiftUI
import Foundation

struct AddressView: View {
    @ObservedObject var order: OrderWrapper
    
    //challenge one, check not pure white space by eliminate all whitespace and new line at font and back.
    var NotValidAddress: Bool{
        let ValidatedAddress = order.order.streetAddress.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if order.order.name.isEmpty || order.order.streetAddress.isEmpty || order.order.city.isEmpty || order.order.zipCode.isEmpty || ValidatedAddress.isEmpty{
            return true
        }
        return false
    }
    
    var body: some View {
        
            Form{
                Section("Address"){
                    TextField("Enter your name", text: $order.order.name)
                    TextField("Enter your address", text: $order.order.streetAddress)
                    TextField("Enter your city", text: $order.order.city)
                    TextField("Entry your zip code", text:$order.order.zipCode)
                }
                
                Section{
                    NavigationLink {
                        //CheckOutView(order: order)
                    } label: {
                        Text("check out")
                    }

                }
                .disabled(NotValidAddress)
            }
            .navigationTitle("Delivery details")
            .navigationBarTitleDisplayMode(.inline)
        
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(order: OrderWrapper())
    }
}
