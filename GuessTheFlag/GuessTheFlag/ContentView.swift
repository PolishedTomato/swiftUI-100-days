//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Deye Lei on 10/11/22.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"]
    let labels = [
        "Estonia": "Flag with three horizontal stripes of equal size. Top stripe blue, middle stripe black, bottom stripe white",
        "France": "Flag with three vertical stripes of equal size. Left stripe blue, middle stripe white, right stripe red",
        "Germany": "Flag with three horizontal stripes of equal size. Top stripe black, middle stripe red, bottom stripe gold",
        "Ireland": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe orange",
        "Italy": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe red",
        "Nigeria": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe green",
        "Poland": "Flag with two horizontal stripes of equal size. Top stripe white, bottom stripe red",
        "Russia": "Flag with three horizontal stripes of equal size. Top stripe white, middle stripe blue, bottom stripe red",
        "Spain": "Flag with three horizontal stripes. Top thin stripe red, middle thick stripe gold with a crest on the left, bottom thin stripe red",
        "UK": "Flag with overlapping red and white crosses, both straight and diagonally, on a blue background",
        "US": "Flag with red and white stripes of equal size, with white stars on a blue background in the top-left corner"
    ]
    @State private var correctAnswer = Int.random(in: 0...2)

    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var cur_score = 0
    @State private var cur_chose = 0
    
    @State private var atQuestion = 0;
    @State private var maxQuestion = false;
    
    
    //swiftUI Day 34 challenger
    //animation will show only that that view, change view won't show
    @State private var spin = true
    @State private var userTap = false
    func userChoseUpdate(number: Int){
        cur_chose = number
    }
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
                        userChoseUpdate(number: number)
                        userTap.toggle()
                        checkAnswer(number)
                    
                    } label: {
                            Image(countries[number])
                                .renderingMode(.original)
                                .clipShape(Rectangle())
                                .shadow(radius: 5)
                                .rotation3DEffect(userTap ? Angle(degrees: cur_chose == number ? 360 : 0) : Angle(degrees: cur_chose == number ? 0 : 360), axis: (x: 0, y: 1, z: 0))
                                .opacity(userTap ? cur_chose == number ? 1 : 0.25 : 1)
                                .scaleEffect(userTap ? cur_chose == number ? 1 : 0.5 : 1)
                                .animation(.default, value: userTap)
                    }
                    .accessibilityLabel("\(labels[countries[number]] ?? "unknown flag")")
                }
                Text("Score is \(cur_score)")
                    .font(.largeTitle)
                    .foregroundColor(.white)
            }
            
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("ok"){
                resetGame()
                userTap.toggle()
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
                userTap.toggle()
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
