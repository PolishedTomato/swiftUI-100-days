//
//  ContentView.swift
//  SwiftUI Day 36
//
//  Created by Deye Lei on 10/25/22.
//

import SwiftUI
class UserInfo : ObservableObject {
    @Published var firstName = "Jesus"
    @Published var lastName = "Lis"
}

struct secondView: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack{
            Text("Hello world")
            Button("Tap to dismiss"){
                dismiss()
            }
            
        }
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("second dismiss"){
                    dismiss()
                }
            }
        }
    }
}

struct ContentView: View {
    @StateObject var user = UserInfo()
    @State private var showSheet = false
    
    @State private var numbers = [Int]()
    @State private var currentNumber = 1
    
    //userDefault
    //@State private var tapCount = UserDefaults.standard.integer(forKey: "Tap")
    @AppStorage ("Tap") private var tapCount = 0
    var body: some View {
        NavigationView{
            VStack {
                Text("The name is \(user.firstName) \(user.lastName)")
                TextField("What is your first name", text: $user.firstName)
                TextField("what is your last name", text: $user.lastName)
                Button("Tap show sheet"){
                    showSheet.toggle()
                }
                
                VStack {
                    List {
                        ForEach(numbers, id: \.self) {
                            Text("Row \($0)")
                        }
                        .onDelete{
                            indexSet in numbers.remove(atOffsets: indexSet)
                        }
                    }
                    
                    Button("Add Number") {
                        
                        numbers.append(currentNumber)
                        
                        currentNumber += 1
                        tapCount += 1
                        UserDefaults.standard.set(tapCount, forKey: "Tap")
                    }
                    
                    Text("\(tapCount) Tap")
                }
                .navigationTitle("onDelete")
                .toolbar {
                    EditButton()
                }
            }
            
        }
        .padding()
        .sheet(isPresented: $showSheet) {
            secondView()
        }
        //JSONEncoder()
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
