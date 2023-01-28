//
//  DiceRollView_ViewModel.swift
//  SwiftUI Day 95
//
//  Created by Deye Lei on 1/27/23.
//

import Foundation
import SwiftUI

extension DiceRollView{
    @MainActor class DiceRollView_ViewModel: ObservableObject{
        init(){
            
        }
        
        init(numberDice: Int, numberSide: Int){
            _result = Published(initialValue: [Dice](repeating: Dice(val: Int.random(in: 0...numberSide), color: .green), count: numberDice))
        }
        
        @Published public var result = [Dice]()
        var arraySum: Int{
            var sum = 0;
            for dice in result{
                sum += dice.val
            }
            return sum
        }
        
        @Published var history:[Int] = []
        
        @Published var isRolling = false
        @Published var RollingTime = Date.now
        
        var rollTime = 2.0
        let timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()
        
        let generator = UINotificationFeedbackGenerator()
        
        func rollDice(numberSide: Int){
            generator.notificationOccurred(.success)
            
            for index in 0...result.count-1 {
                result[index] = Dice(val: Int.random(in: 1...numberSide), color: .green)
            }
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
    }
}
