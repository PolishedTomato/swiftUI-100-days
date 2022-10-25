//
//  ContentView.swift
//  edutainment
//
//  Created by Deye Lei on 10/24/22.
//

import SwiftUI

struct ContentView: View {
    @FocusState private var focus
    @State private var difficulty = 1;
    @State private var ans = ""
    @State private var showAlert = false
    @State private var inGame = false
    @State private var score = 0
    
    let questions = [(0,0), (1,5), (5,7), (9, 10), (4, 1), (3,7), (10, 10), (9,3), (1, 7), (4, 6), (6, 6), (5,5), (1,5), (4,4), (2,7)]
    
    let questions2 = [(10,100), (15,52), (15,74), (29, 10), (74, 14), (32,75), (10, 10), (6,13), (1, 70), (43, 32), (52, 6), (9,52), (11,52), (44,44), (22,77)]
    
    @State private var cur_question = 0
    
    @State private var TapButtonOne = false
    @State private var TapButtonTwo = false
    @State private var TapButtonThree = false
    @State private var TapButtonStart = false
    @State private var numOfQuestions = 5
    
    func checkAnswer(){
        if(difficulty == 1 && Int(ans) == questions[cur_question].0 * questions[cur_question].1 ){
            score += 1
        }
        else if(difficulty == 2 && Int(ans) == questions2[cur_question].0 * questions2[cur_question].1){
            score += 1
        }
        
        if cur_question + 1 == numOfQuestions{
            showAlert = true
            resetGame()
        }
    }
    
    func resetGame(){
        numOfQuestions = 5;
        TapButtonStart = false;
        TapButtonOne = false;
        TapButtonTwo = false;
        TapButtonThree = false;
        cur_question = -1
        score = 0
        inGame = false
        ans = ""
    }
    var body: some View {
        NavigationView{
            ZStack{
                RadialGradient(colors: [.yellow, .orange,.green], center: .top, startRadius: 50, endRadius: 300)
                    .ignoresSafeArea()
                
                VStack(spacing: 50){
                    Text("Multiply Table Game")
                        .foregroundColor(.white)
                        .font(.largeTitle.bold())
                    
                    HStack{
                        Button("5 question"){
                            TapButtonOne.toggle()
                            numOfQuestions = 5
                        }
                        .frame(width: 100, height: 85)
                        .buttonStyle(.borderedProminent)
                        .background(.blue)
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                        .scaleEffect(TapButtonOne ? 1.25 : 1)
                        .animation(.interpolatingSpring(stiffness: 100, damping: 2).repeatCount(1, autoreverses: true), value: TapButtonOne)
                        
                        Button("10 question"){
                            TapButtonTwo.toggle()
                            numOfQuestions = 10
                        }
                        .frame(width: 100, height: 85)
                        .buttonStyle(.borderedProminent)
                        .background(.blue)
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                        .scaleEffect(TapButtonTwo ? 1.25 : 1)
                        .animation(.interpolatingSpring(stiffness: 100, damping: 2).repeatCount(1, autoreverses: true), value: TapButtonTwo)
                        
                        Button("15 question"){
                            TapButtonThree.toggle()
                            numOfQuestions = 15
                        }
                        .frame(width: 100, height: 85)
                        .buttonStyle(.borderedProminent)
                        .background(.blue)
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                        .scaleEffect(TapButtonThree ? 1.25 : 1)
                        .animation(.interpolatingSpring(stiffness: 100, damping: 2).repeatCount(1, autoreverses: true), value: TapButtonThree)
                        
                    }
                    
                    Stepper(difficulty == 1 ? "Start with 1 digit" : "Start with 2 digits", value: $difficulty, in: 1...3)
                        .font(.headline.bold())
                        .foregroundColor(.white)
                        .padding(20)
                    Button {
                        TapButtonStart.toggle()
                        inGame = true;
                    } label: {
                        Label("Start", systemImage: "play")
                            .frame(width: 100, height: 100)
                            .background(.yellow)
                            .clipShape(Capsule())
                            .scaleEffect(TapButtonStart ? 1.25 : 1)
                            .animation(.interpolatingSpring(stiffness: 100, damping: 2).repeatCount(1, autoreverses: true), value: TapButtonStart)
                    }
                    
                    if inGame{
                        HStack(spacing: 20){
                            Text(" \(difficulty == 1 ? questions[cur_question].0 : questions2[cur_question].0) x \(difficulty == 1 ? questions[cur_question].1 : questions2[cur_question].1) = ")
                                .foregroundColor(.white)
                                .font(.largeTitle.bold())
                            
                            TextField("?", text: $ans)
                                .foregroundColor(.white)
                                .font(.largeTitle.bold())
                                .keyboardType(.numberPad)
                                .onSubmit{
                                    checkAnswer()
                                    
                                    cur_question += 1
                                    ans = ""
                                    focus = true
                                }
                                .focused($focus)
                            
                        }
                    }
                }
                
            }
        }
        .alert("Game Complete", isPresented: $showAlert) {
            Button("Ok"){
                
            }
        } message: {
            Text("your score is \(score)")
        }

        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
