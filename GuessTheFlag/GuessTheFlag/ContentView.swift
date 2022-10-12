//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Deye Lei on 10/11/22.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"]
    @State private var correctAnswer = Int.random(in: 0...2)

    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var cur_score = 0
    @State private var cur_chose = 0
    
    @State private var atQuestion = 0;
    @State private var maxQuestion = false;
    
    func checkAnswer(_ number: Int){
        if(number == correctAnswer)
        {
            scoreTitle = "correct!"
            cur_score += 1
        }
        else{
            scoreTitle = "wrong :("
            cur_score -= 1
        }
        atQuestion += 1
        if(atQuestion != 8){
            showingScore = true
        }
        else{
            maxQuestion = true
        }
        cur_chose = number
    }
    
    func resetGame(){
        countries.shuffle()
        correctAnswer = Int.random(in: 0..<3)
        
    }
    
    func resetWholeGame(){
        resetGame()
        cur_score = 0;
        atQuestion = 0;
    }
    
    var body: some View {
        ZStack{
            RadialGradient(gradient: Gradient(colors: [.yellow,.green,.pink]), center: .top, startRadius: 20, endRadius: 300)
                .ignoresSafeArea()
            
            
            VStack(spacing: 30){
                VStack {
                    Text("Tap the flag of")
                        .foregroundStyle(.white)
                        .font(.subheadline.weight(.heavy))
                    Text(countries[correctAnswer])
                        .foregroundStyle(.secondary)
                        .font(.largeTitle.weight(.semibold))
                }
                .padding()
                
                
                ForEach(0..<3){
                    number in
                    Button{
                        checkAnswer(number)
                    } label: {
                        Image(countries[number])
                            .renderingMode(.original)
                            .clipShape(Rectangle())
                            .shadow(radius: 5)
                    }
                }
                Text("Score is \(cur_score)")
                    .font(.largeTitle)
                    .foregroundColor(.white)
            }
            
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("ok"){
                resetGame()
            }
        } message: {
            VStack{
                Text("The flag is of \(countries[cur_chose])")
                Text("Your score is \(cur_score)")
            }
            
        }
        .alert("You Finish the game!", isPresented: $maxQuestion) {
            Button("Tap to play again :)"){
                resetWholeGame()
            }
        } message: {
            Text("Your score is \(cur_score)")
        }

        

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
