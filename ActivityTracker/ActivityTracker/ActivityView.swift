//
//  ActivityView.swift
//  ActivityTracker
//
//  Created by Deye Lei on 11/4/22.
//

import SwiftUI
import Foundation

struct ActivityView: View {
    @ObservedObject var activities: Activities
    let activity: Activity
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationView{
            List{
                Section("Subject"){
                    Text(activity.name)
                }
                Section("From and To"){
                    HStack{
                        Text(activity.startTime.formatted(date: .omitted , time: .shortened))
                        Text(" - ")
                        Text(activity.endTime.formatted(date: .omitted, time: .standard))
                    }
                }
                ZStack{
                    Color.red
                        .padding(-19)
                    Button {
                        let index = activities.activities.firstIndex { x in
                            return x.id == activity.id
                        }
                        activities.activities.remove(at: index ?? 0)
                    } label: {
                        Text("Delete")
                            .foregroundColor(.white)
                    }
                    
                }
                .frame(maxWidth: .infinity)
            }
        }
    }
}

struct ActivityView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityView(activities: Activities.sample(),activity: Activities.sampleData[0])
    }
}
