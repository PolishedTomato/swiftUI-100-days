//
//  CheckOutView.swift
//  cupCakeCorner
//
//  Created by Deye Lei on 11/8/22.
//

import SwiftUI
import Foundation

struct CheckOutView: View {
    @ObservedObject var order: Order
    var body: some View {
        NavigationView{
            ScrollView{
                VStack(spacing: 20){
                    AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg")) {
                        image in
                        image
                            .resizable()
                            .scaledToFit()
                            .clipShape(Capsule())
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(height: 200)
                    
                    Text("your current cost is \(order.cost, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))")
                        .font(.title)
                    
                    Button("Place Order"){
                        
                    }
                    .padding()
                    
                }
            }
            .navigationTitle("Check Out")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct CheckOutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckOutView(order: Order())
    }
}
