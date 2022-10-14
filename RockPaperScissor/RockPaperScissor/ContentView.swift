//
//  ContentView.swift
//  RockPaperScissor
//
//  Created by Deye Lei on 10/14/22.
//

import SwiftUI

struct ContentView: View {
    @State private var score = 0
    @State private var answers = ["Rock", "Paper", "Scissor"]
    
    @State private var user_ans = "Rock"
    @State private var tapped = false
    @State private var gameComplete = false
    @State private var win = 0
    @State private var round = 1;
    @State private var message = "Correct!"
    func checkAns(){
        if(user_ans == answers[0]){
            win = 0
            message = "you didn't look but also didn't win"
        }
        else if(user_ans == "Rock" && answers[0] == "Scissor"){
            win = 1
            score += 1
            message = "Correct!"
        }
        else if(user_ans == "Scissor" && answers[0] == "Paper"){
            win = 1
            score += 1
            message = "Correct!"
        }
        else if(user_ans == "Paper" && answers[0] == "Rock"){
            win = 1
            score += 1
            message = "Correct!"
        }
        else{
            message = "incorrect"
            win = -1
        }
        
        if(round == 10){
            gameComplete = true
        }
        else{
            tapped = true
        }
    }
    
    func playAgain(){
        answers.shuffle()
        round += 1
    }
    
    func resetGame(){
        playAgain()
        round = 1
        score = 0
    }
    
    var body: some View {
        NavigationView{
            ZStack{
                RadialGradient(colors: [.yellow, .green], center: .center
                               , startRadius: 20.0, endRadius: 200)
                .ignoresSafeArea()
                
                VStack(spacing: 50) {
                    Text("Lets play Rock Paper Scissor")
                        .foregroundColor(.white)
                        .font(.subheadline.weight(.bold))
                        .foregroundStyle(.ultraThinMaterial)
                    HStack{
                        Spacer()
                        Button {
                            user_ans = "Rock"
                            checkAns()
                        } label: {
                            Text("Rock")
                                .foregroundColor(.white)
                                .font(.largeTitle.weight(.bold))
                        }
                        Spacer()
                        Button {
                            user_ans = "Paper"
                            checkAns()
                        } label: {
                            Text("Paper")
                                .foregroundColor(.white)
                                .font(.largeTitle.weight(.bold))
                            
                        }
                        Spacer()
                    }
                    Button {
                        user_ans = "Scissor"
                        checkAns()
                    } label: {
                        Text("Scissor")
                            .foregroundColor(.white)
                            .font(.largeTitle.weight(.bold))
                        
                    }
                    
                    Text("The NPC is showing \(answers[0])")
                        .foregroundColor(.white)
                        .font(.largeTitle.weight(.medium))
                        .padding(20)
                }
                .alert(message, isPresented: $tapped){
                    Button("Play again"){
                        playAgain()
                    }
                } message: {
                    Text("your score is \(score)")
                }
                .alert("Game Complete!", isPresented: $gameComplete) {
                    Button("Tap to restart"){
                        resetGame()
                    }
                } message: {
                    Text("your score is \(score)")
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
