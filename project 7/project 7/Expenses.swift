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
    static func sampleData()->Expense{
        let data = Expense()
        data.personalItems.append(ExpenseItem(name: "Sample1", type: "personal", amount: 5.0))
        data.personalItems.append(ExpenseItem(name: "Sample2", type: "personal", amount: 15.0))
        data.personalItems.append(ExpenseItem(name: "Sample3", type: "personal", amount: 150.0))
        
        data.businessItems.append(ExpenseItem(name: "Sample1", type: "business", amount: 5.0))
        data.businessItems.append(ExpenseItem(name: "Sample2", type: "business", amount: 15.0))
        data.businessItems.append(ExpenseItem(name: "Sample3", type: "business", amount: 150.0))
        return data
    }
    init(){
        if let savePersonalItems = UserDefaults.standard.data(forKey: "ExpenseItem.personalItem"){
            if let data = try? JSONDecoder().decode([ExpenseItem].self, from: savePersonalItems){
                personalItems = data
            }
        }
        
        if let saveBusinessItems = UserDefaults.standard.data(forKey: "ExpenseItem.businessItem"){
            if let data = try? JSONDecoder().decode([ExpenseItem].self, from: saveBusinessItems){
                businessItems = data
            }
        }
        
        personalItems = []
        businessItems = []
    }
    @Published var personalItems : [ExpenseItem] = [] {
        didSet{
            let encoder = JSONEncoder()
            if let data = try? encoder.encode(personalItems){
                UserDefaults.standard.set(data, forKey: "ExpenseItem.personalItem")
                
            }
        }
    }
    
    @Published var businessItems : [ExpenseItem] = [] {
        didSet{
            let encoder = JSONEncoder()
            if let data = try? encoder.encode(businessItems){
                UserDefaults.standard.set(data, forKey: "ExpenseItem.businessItem")
                
            }
        }
    }
}
