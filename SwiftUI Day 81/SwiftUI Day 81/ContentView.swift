//
//  ContentView.swift
//  SwiftUI Day 81
//
//  Created by Deye Lei on 12/29/22.
//

import SwiftUI
import UserNotifications
import SamplePackage

struct ContentView: View {
    @State private var backgroundColor = Color.red
    let possibleNumbers = Array(1...60)
    
    var selected:[Int] {
        possibleNumbers.random(7).sorted()
    }
    var results: String {
        let strings = selected.map{String($0)}
        return strings.joined(separator: ",")
    }

    var body: some View {
        VStack {
            Text("\(results)")
                .padding()
                .background(backgroundColor)

            Text("Change Color")
                .padding()
                .contextMenu {
                    Button(role: .destructive) {
                        backgroundColor = .red
                    }label: {
                    Label("Red", systemImage: "checkmark.circle.fill")
                        .foregroundColor(.red)
                }

                    Button("Green") {
                        backgroundColor = .green
                    }

                    Button("Blue") {
                        backgroundColor = .blue
                    }
                }
            List {
                Text("Taylor Swift")
                    .swipeActions {
                        Button {
                            print("Hi")
                        } label: {
                            Label("Send message", systemImage: "message")
                        }
                    }
                    .swipeActions(edge: .trailing) {
                                Button {
                                    print("Hi")
                                } label: {
                                    Label("Pin", systemImage: "pin")
                                }
                                .tint(.orange)
                            }
            }
            
            VStack {
                Button("Request Permission") {
                    //asking type of notification
                    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                        if success {
                            print("All set!")
                        } else if let error = error {
                            print(error.localizedDescription)
                        }
                    }
                    
                    
                }

                Button("Schedule Notification") {
                    let content = UNMutableNotificationContent()
                    content.title = "Feed the cat"
                    content.subtitle = "It looks hungry"
                    content.sound = UNNotificationSound.default

                    // show this notification five seconds from now
                    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

                    // choose a random identifier
                    let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

                    // add our notification request
                    UNUserNotificationCenter.current().add(request)
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
