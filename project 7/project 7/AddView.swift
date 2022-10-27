//
//  AddView.swift
//  project 7
//
//  Created by Deye Lei on 10/25/22.
//

import SwiftUI
import Foundation

struct AddView: View {
    @ObservedObject var expense: Expense
    
    @State var name: String = ""
    @State var type: String = "Personal"
    @State var amount: Double = 0.0
    
    let choice = ["Personal", "Business"]
    
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationView{
            Form {
                TextField("Enter your expense name", text: $name)
                Picker("Expense type: ", selection: $type) {
                    ForEach(choice, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(.segmented)
                TextField("Enter your expense cost", value: $amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD") )
            }
            .toolbar{
                ToolbarItem(placement: .cancellationAction) {
                    Button("cancel", role: .cancel){
                        dismiss()
                    }
                }

                ToolbarItem(placement: .confirmationAction) {
                    Button("Save to your expense", role: .destructive){
                        let item = ExpenseItem(name: name, type: type, amount: amount)
                        withAnimation{
                            if item.type == "Personal"{
                                expense.personalItems.append(item)
                            }
                            else{
                                expense.businessItems.append(item)
                            }
                        }
                        dismiss()
                    }
                }
            }
            .navigationTitle("Add expense")
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expense: Expense())
    }
}
