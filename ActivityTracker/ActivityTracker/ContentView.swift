//
//  ContentView.swift
//  ActivityTracker
//
//  Created by Deye Lei on 11/4/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var activities = Activities()
    let layout = [GridItem(.adaptive(minimum:150))]
    @State private var showSheet = false
    
    
    var body: some View {
        NavigationView{
            VStack(){
                LazyVGrid(columns:layout){
                    ForEach(activities.activities){
                        activity in
                        NavigationLink {
                            ActivityView(activities: activities, activity: activity)
                                
                        } label: {
                            ActivityLabelView(name: activity.name)
                                .padding(.vertical)
                        }

                        
                    }
                }
            }
            .navigationTitle("Activities")
            .toolbar{
                ToolbarItem {
                    Button("Add"){
                        showSheet.toggle()
                    }
                }
            }
            .sheet(isPresented: $showSheet) {
                AddActivityView(activities: activities)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(activities: Activities.sample())
    }
}
