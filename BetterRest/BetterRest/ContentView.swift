//
//  ContentView.swift
//  BetterRest
//
//  Created by Deye Lei on 10/16/22.
//

import SwiftUI
import CoreML

struct ContentView: View {
    @State private var coffeeAmount = 1
    @State private var sleepHours = 8.0
    @State private var wakeUp = defaultWakeUP
    
    @State private var alertTitle = "Time to sleep!"
    @State private var alertMessage = "you better go to sleep"
    @State private var toSleep = false
    
    static var defaultWakeUP :Date {
        var component = DateComponents()
        component.hour = 8
        component.minute = 0
        
        return Calendar.current.date(from: component) ?? Date.now
    }
    
    var dateStart: Date{
        var component = DateComponents()
        component.hour = 4
        component.minute = 0
        return Calendar.current.date(from: component) ?? Date.now
    }
    
    var dateEnd: Date{
        var component = DateComponents()
        component.hour = 12
        component.minute = 0
        return Calendar.current.date(from: component) ?? Date.now
    }
    
    func calculateBedtime(){
        do{
            let config = MLModelConfiguration()
            let model = try BetterRest_1(configuration: config)
            
            let component = Calendar.current.dateComponents([.hour,. minute], from: wakeUp)
            //get data as in second
            let hour = (component.hour ?? 0) * 60 * 60
            let minute = (component.minute ?? 0) * 60
            
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepHours, coffee: Double(coffeeAmount))
            
            let sleepTime = wakeUp - prediction.actualSleep
            
            alertTitle = "Your ideal bedtime is ..."
            alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)
            toSleep = true
        }
        catch{
            alertTitle = "Error"
            alertMessage = "There was a error sorry."
            toSleep = true
        }
    }
    
    var Bedtime : String{
        do{
            let config = MLModelConfiguration()
            let model = try BetterRest_1(configuration: config)
            
            let component = Calendar.current.dateComponents([.hour,. minute], from: wakeUp)
            //get data as in second
            let hour = (component.hour ?? 0) * 60 * 60
            let minute = (component.minute ?? 0) * 60
            
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepHours, coffee: Double(coffeeAmount))
            
            let sleepTime = wakeUp - prediction.actualSleep
            
            alertTitle = "Your ideal bedtime is ..."
            alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)
            return sleepTime.formatted(date: .omitted, time: .shortened)
        }
        catch{
            alertTitle = "Error"
            alertMessage = "There was a error sorry."
            toSleep = true
        }
        return "Some error occur"
    }
    var body: some View {
        NavigationView{
            
            Form {
                Section{
                    DatePicker("Wake up time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                } header:{
                    Text("Please select your wake up time")
                        .font(.headline.weight(.bold))
                }
                Section{
                    Stepper("sleep for \(sleepHours.formatted()) hours", value: $sleepHours, in: 4...12, step: 0.25)
                    
                } header: {
                    Text("Please select your sleep hour")
                        .font(.headline)
                }
                
                Section{
                    /*
                    Stepper(coffeeAmount == 1 ? " 1 cup of coffee" : "\(coffeeAmount) cups of coffee", value: $coffeeAmount, in: 0...10, step: 1)
                     */
                    
                    Picker("Coffee intake daily for ", selection: $coffeeAmount) {
                        ForEach(0..<11){
                            if($0 == 1){
                                Text("1 cup")
                            }
                            else{
                                Text("\($0) cups")
                            }
                        }
                    }
                } header: {
                    Text("Coffee intake")
                        .font(.headline)
                }
                ZStack{
                    RadialGradient(colors: [.yellow,.green], center: .center, startRadius: 20.0, endRadius: 200)
                        .padding(-50)
                    VStack{
                        Text("your desire bed time is \(Bedtime)")
                            .font(.largeTitle.weight(.bold))
                    }
                }
            }
            .navigationTitle("RestBetter")
            .toolbar{
                Button {
                    calculateBedtime()
                } label: {
                    Text("Calculate")
                }
            }

        }
        .alert(alertTitle, isPresented: $toSleep) {
            Button(action: {}) {
                Text("Ok!")
            }
        } message: {
            Text(alertMessage)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
