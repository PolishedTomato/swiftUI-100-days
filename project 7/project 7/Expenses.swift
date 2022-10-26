//
//  Expenses.swift
//  project 7
//
//  Created by Deye Lei on 10/25/22.
//

import Foundation

struct ExpenseItem : Identifiable, Codable{
    var id = UUID()
    var name: String
    var type: String
    var amount: Double
}
//[ExpenseItem].self refer to this array type
class Expense : ObservableObject{
    init(){
        if let saveItems = UserDefaults.standard.data(forKey: "ExpenseItem"){
            if let data = try? JSONDecoder().decode([ExpenseItem].self, from: saveItems){
                items = data
            }
        }
        
        items = []
    }
    @Published var items : [ExpenseItem] = [] {
        didSet{
            let encoder = JSONEncoder()
            if let data = try? encoder.encode(items){
                UserDefaults.standard.set(data, forKey: "ExpenseItem")
                
            }
        }
    }
}
