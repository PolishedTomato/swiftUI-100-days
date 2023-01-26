//
//  DiceRollView.swift
//  SwiftUI Day 95
//
//  Created by Deye Lei on 1/26/23.
//

import Foundation
import SwiftUI

struct DiceRollView: View {
    @State var result = [Dice]()
    @State var history:[Int] = []
    @State var rotate = true
    let numberSide: Int
    
    let timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()
    
    var rollTime = 2.0
    @State var isRolling = false
    @State var RollingTime = Date.now
    
    let generator = UINotificationFeedbackGenerator()
    
    var arraySum: Int{
        var sum = 0;
        for dice in result{
            sum += dice.val
        }
        return sum
    }
    
    func rollDice(){
        generator.notificationOccurred(.success)
        
        for index in 0...result.count-1 {
            result[index] = Dice(val: Int.random(in: 1...numberSide), color: .green)
        }
    }
    
    func loadData(){
        let url = FileManager.SavePath
        if let data = try? Data(contentsOf: url){
            do{
                let decoded = try JSONDecoder().decode([Int].self, from: data)
                history = decoded
                print("load success")
                
            }
            catch{
                print(error)
                print("load failed")
            }
        }
    }
    
    init(numberDice: Int, numberSide: Int){
        self.numberSide = numberSide
        _result = State(initialValue: [Dice].init(repeating: Dice(val: Int.random(in: 1...numberSide), color: .green), count: numberDice))
        
        loadData()
    }
    
    func save(){
        let url = FileManager.SavePath
        
        if let encoded = try? JSONEncoder().encode(history){
            do{
                try encoded.write(to: url)
                print("save success")
            }
            catch{
                print(error)
                print("save failed")
            }
        }
    }
    
    var body: some View {
        NavigationView{
            VStack(alignment: .center, spacing: 30){
                HStack{
                    ForEach(result){ dice in
                        DiceView(value: dice.val, color: dice.color, flip: rotate)
                    }
                    .rotation3DEffect(rotate ? .degrees(360) : .degrees(0), axis: (x: 0, y: 1, z: 0))
                    .animation(.default, value: rotate)
                }
                
                Button{
                    if( isRolling == false){
                        generator.prepare()
                        RollingTime = Date.now
                        isRolling = true
                    }
                    
                } label:{
                    Label("Reroll", systemImage: "dice")
                        .font(.title)
                        .foregroundColor(.pink)
                }
                
                List{
                    Section("Roll history"){
                        ForEach(history, id: \.self){ th in
                            Text("\(th)")
                        }
                    }
                }
            }
            .navigationTitle("Dices Rolling Time!")
        }
        //notice time is a Date object
        .onReceive(timer) { time in
            if isRolling{
                if RollingTime.distance(to: time) > 2{
                    isRolling = false
                    history.append(arraySum)
                    save()
                }
                else{
                    rollDice()
                }
            }
        }
        .onAppear(perform: loadData)
    }
}

struct DiceRollView_Previews: PreviewProvider {
    static var previews: some View {
        DiceRollView(numberDice: 6, numberSide: 6)
    }
}
