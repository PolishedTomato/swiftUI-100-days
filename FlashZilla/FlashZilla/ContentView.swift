//
//  ContentView.swift
//  FlashZilla
//
//  Created by Deye Lei on 1/13/23.
//
import Foundation
import SwiftUI

struct ContentView: View {
    @Environment(\.accessibilityDifferentiateWithoutColor) var colorBlindness
    @Environment(\.scenePhase) var scene
    @Environment(\.accessibilityVoiceOverEnabled) var voiceOverEnable
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        NavigationView{
            ZStack {
                Image(decorative: "background")
                    .resizable()
                    .ignoresSafeArea()
                
                VStack {
                    if colorBlindness || voiceOverEnable{
                        HStack{
                            Button{
                                withAnimation{
                                    guard viewModel.cards.count > 0 else {return}
                                    viewModel.cards.removeLast()
                                }
                            } label: {
                                Image(systemName: "xmark.seal")
                                    .padding()
                                    .frame(width: 50, height: 50)
                            }
                            .accessibilityLabel("Wrong")
                            .accessibilityHint("Mark this answer as wrong")
                            
                            Spacer()
                            
                            Button{
                                withAnimation{
                                    guard viewModel.cards.count > 0 else {return}
                                    viewModel.cards.removeLast()
                                }
                            } label: {
                                Image(systemName: "checkmark.seal")
                                    .frame(width: 50, height: 50)
                                    .padding()
                            }
                            .accessibilityLabel("Correct")
                            .accessibilityHint("Mark this answer as correct")
                        }
                        .padding(.horizontal)
                        .foregroundColor(.white)
                        .font(.title)
                    }
                    
                    Text("Time remain: \(viewModel.timeRemain)")
                        .foregroundColor(.white)
                        .font(.largeTitle)
                    
                    ZStack {
                        ForEach(viewModel.cards) { card in
                            CardView(card: card, score: $viewModel.score){
                                withAnimation{
                                    viewModel.remove()
                                }
                            } guessWrong: {
                                viewModel.guessWrong()
                            }
                            //.stacked(at: viewModel.index, in: viewModel.cards.count)
                            //.allowsHitTesting(viewModel.index == viewModel.cards.count - 1)
                            //.accessibilityHidden(viewModel.index < viewModel.cards.count - 1)
                            //to make card which go back to the array, I have to not use index but loop through the collection.
                        }
                        
                    }
                    .allowsHitTesting(viewModel.timeRemain > 0)
                    
                }
                
                
            }
            .onReceive(viewModel.timer) { time in
                guard viewModel.isActive == true else {return}
                
                if(viewModel.timeRemain > 0){
                    viewModel.timeRemain -= 1
                    if(viewModel.timeRemain == 0){
                        viewModel.showAlert = true
                    }
                }
            }
            .onChange(of: scene) { newValue in
                if newValue == .active {
                    if viewModel.cards.isEmpty == false{
                        viewModel.isActive = true
                    }
                }
                else{
                    viewModel.isActive = false
                }
            }
            .alert("Times up", isPresented: $viewModel.showAlert) {
                Button("press to retry"){
                    viewModel.resetCard()
                }
            } message: {
                Text("you finish the game with \(viewModel.score) correct answer in 100 seconds!")
            }
            .toolbar {
                Button{
                    viewModel.resetCard()
                } label: {
                    Image(systemName: "restart")
                }
                
                Button{
                    viewModel.showEditView = true
                } label: {
                    Image(systemName: "plus.app")
                        
                }
            }
            .sheet(isPresented: $viewModel.showEditView) {
                EditView{
                    viewModel.cards = $0
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

extension View {
    func stacked(at position: Int, in total: Int) -> some View {
        let offset = Double(total - position)
        return self.offset(x: 0, y: offset * 10)
    }
}
