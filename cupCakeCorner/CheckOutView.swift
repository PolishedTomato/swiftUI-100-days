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
    
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    
    func placeOrder() async{
        //encode data
        guard let encoded = try? JSONEncoder().encode(order)
        else{
            print("Encode failed")
            return
        }
        
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        //comment out this will make it fail
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        do {
            //URLSession.shared.upload will send the Json with specified request and return a tuple from server of (data, URLResponse)
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            
            
            let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
            confirmationMessage = "Your order for \(decodedOrder.quantity)x \(Order.types[decodedOrder.type].lowercased()) cupcakes is on its way!"
            showingConfirmation = true
            
        } catch {
            print("Checkout failed.")
        }
        
        
    }
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
                        Task{
                            await placeOrder()
                        }
                    }
                    .padding()
                    
                }
            }
            .navigationTitle("Check Out")
            .navigationBarTitleDisplayMode(.inline)
        }
        .alert("Thank you!", isPresented: $showingConfirmation) {
            Button("OK") { }
        } message: {
            Text(confirmationMessage)
        }
    }
}

struct CheckOutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckOutView(order: Order())
    }
}
