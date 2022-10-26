//
//  ContentView.swift
//  project 7
//
//  Created by Deye Lei on 10/25/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var MyExpense = Expense()
    
    
    @State private var showAddSheet = false
    var body: some View {
        VStack {
            NavigationView{
                List{
                    ForEach(MyExpense.items){
                        item in
                        HStack{
                            VStack{
                                Text(item.name)
                                    .font(.headline)
                                Text(item.type)
                                    .font(.subheadline)
                            }
                            Spacer()
                            Text("\(item.amount)")
                                .font(.headline)
                        }
                        //Text("\(item.name)")
                    }
                    .onDelete { IndexSet in
                        MyExpense.items.remove(atOffsets: IndexSet)
                    }
                }
                .toolbar{
                    Button{
                        showAddSheet = true
                    } label: {
                        Label("Add", systemImage: "plus")
                    }
                }
                .sheet(isPresented: $showAddSheet) {
                    AddView(expense: MyExpense)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
