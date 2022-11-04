//
//  AddActivityView.swift
//  ActivityTracker
//
//  Created by Deye Lei on 11/4/22.
//
import SwiftUI
import Foundation

struct AddActivityView: View {
    @ObservedObject var activities: Activities
    @State private var name = ""
    @State private var startDate = Date.now
    @State private var endDate = Date.now
    
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationView{
            Form{
                Section("Activity name"){
                    TextField("Enter the name", text: $name)
                }
                
                DatePicker("Start Time", selection: $startDate, in: startDate...)
                
                DatePicker("End Time", selection: $endDate, in: startDate...)
            }
            .toolbar{
                ToolbarItem(placement: .confirmationAction) {
                    Button("Confirm"){
                        let newItem = Activity(name: name, startTime: startDate, endTime: endDate)
                        activities.activities.append(newItem)
                        dismiss()
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("cancel", role: .destructive){
                        dismiss()
                    }
                }
            }
        }
    }
}

struct AddActivityView_Previews: PreviewProvider {
    static var previews: some View {
        AddActivityView(activities: Activities.sample())
    }
}
