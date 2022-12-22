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
                VStack{
                    List{
                        ForEach(MyExpense.personalItems){
                            item in
                            HStack{
                                VStack{
                                    Text(item.name)
                                        .font(.headline)
                                    Text(item.type)
                                        .font(.subheadline)
                                }
                                Spacer()
                                Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                                    .font(.headline)
                                    .foregroundColor(item.amount <= 10.0 ? .green : (item.amount > 100 ? .red : .blue))
                                    .scaleEffect(item.amount > 100.0 ? 1.25 : 1)
                                    .foregroundStyle((10.0 < item.amount && item.amount < 100.0) ? .ultraThinMaterial : .regularMaterial)
                            }
                            .accessibilityElement(children: .ignore)
                            .accessibilityLabel("\(item.name) \(item.amount)")
                            .accessibilityHint("\(item.type)")
                        }
                        .onDelete { IndexSet in
                            withAnimation{
                                MyExpense.personalItems.remove(atOffsets: IndexSet)
                            }
                        }
                    }
                    
                    List {
                        ForEach(MyExpense.businessItems){
                            item in
                            HStack{
                                VStack{
                                    Text(item.name)
                                        .font(.headline)
                                    Text(item.type)
                                        .font(.subheadline)
                                }
                                Spacer()
                                Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                                    .font(.headline)
                                    .foregroundColor(item.amount <= 10.0 ? .yellow : (item.amount > 100 ? .pink : .orange))
                                    .scaleEffect(item.amount > 100.0 ? 1.25 : 1)
                                    .foregroundStyle((10.0 < item.amount && item.amount < 100.0) ? .ultraThinMaterial : .regularMaterial)
                            }
                            .accessibilityElement(children: .ignore)
                            .accessibilityLabel("\(item.name) \(item.amount.formatted())")
                            .accessibilityHint("\(item.type)")
                        }
                        .onDelete { IndexSet in
                            withAnimation{
                                MyExpense.businessItems.remove(atOffsets: IndexSet)
                            }
                        }
                    }
                }
                .toolbar{
                    Button{
                        showAddSheet = true
                        print("pressed")
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
        ContentView(MyExpense: Expense.sampleData())
    }
}
