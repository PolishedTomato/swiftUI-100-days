//
//  DiceRollView.swift
//  SwiftUI Day 95
//
//  Created by Deye Lei on 1/26/23.
//

import Foundation
import SwiftUI

struct DiceRollView: View {
    @StateObject var viewModel = DiceRollView_ViewModel()
    
    let numberSide: Int
    let numberDice: Int
    
    //ordrer execution: initalizer->onApear()
    init(numberDice: Int, numberSide: Int){
        self.numberSide = numberSide
        self.numberDice = numberDice
        _viewModel = StateObject(wrappedValue: DiceRollView_ViewModel(numberDice: numberDice, numberSide: numberSide))
    }
    
    //placing this method in the view model, and use it in onAppear will lose global main actor. We can't do that because viewModel should run on main thread, so I leave this method outside of viewModel
    func loadData(){
        let url = FileManager.SavePath
        if let data = try? Data(contentsOf: url){
            do{
                let decoded = try JSONDecoder().decode([Int].self, from: data)
                viewModel.history = decoded
                print("load success")
                
            }
            catch{
                print(error)
                print("load failed")
            }
        }
    }
    
    var body: some View {
        NavigationView{
            VStack(alignment: .center, spacing: 30){
                HStack{
                    ForEach(viewModel.result){ dice in
                        DiceView(value: dice.val, color: dice.color, flip: true)
                    }
                }
                
                Button{
                    if( viewModel.isRolling == false){
                        viewModel.generator.prepare()
                        viewModel.RollingTime = Date.now
                        viewModel.isRolling = true
                    }
                    
                } label:{
                    Label("Reroll", systemImage: "dice")
                        .font(.title)
                        .foregroundColor(.pink)
                        .accessibilityLabel("Tap to re-roll your dice")
                }
                
                List{
                    Section("Roll history"){
                        ForEach(viewModel.history, id: \.self){ th in
                            Text("\(th)")
                        }
                    }
                }
            }
            .navigationTitle("Dices Rolling Time!")
        }
        //notice time is a Date object
        .onReceive(viewModel.timer) { time in
            if viewModel.isRolling{
                if viewModel.RollingTime.distance(to: time) > 2{
                    viewModel.isRolling = false
                    viewModel.history.append(viewModel.arraySum)
                    viewModel.save()
                }
                else{
                    viewModel.rollDice(numberSide: numberSide)
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
