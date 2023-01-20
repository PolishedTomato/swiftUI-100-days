//
//  EditView.swift
//  FlashZilla
//
//  Created by Deye Lei on 1/19/23.
//

import Foundation
import SwiftUI

struct EditView: View {
    @State var cards:[Card] = []
    @State var newPrompt = ""
    @State var newAnswer = ""
    @State var answerIsTrue = true
    @State var answerIsFalse = false
    @Environment(\.dismiss) var dismiss
    
    let saveAction: (([Card]) -> Void)?
    
    func saveData(){
        if let encoded = try? JSONEncoder().encode(cards){
            UserDefaults.standard.set(encoded, forKey: "Cards")
        }
        saveAction?(cards)
        dismiss()
    }
    
    func loadData(){
        if let data = UserDefaults.standard.data(forKey: "Cards"){
            if let decoded = try? JSONDecoder().decode([Card].self, from: data){
                cards = decoded
            }
        }
    }
    
    func deleteCard(at index: IndexSet){
        cards.remove(atOffsets: index)
    }
    
    func addCard(){
        let prompt = newPrompt.trimmingCharacters(in: .whitespaces)
        let answer = newAnswer.trimmingCharacters(in: .whitespaces)
        
        guard prompt.isEmpty == false && answer.isEmpty == false
        else{return}
        
        let newCard = Card(prompt: prompt, answer: answer, isTrue: answerIsTrue)
        
        cards.append(newCard)
        newPrompt = ""
        newAnswer = ""
    }
    
    var body: some View {
        NavigationView{
            List{
                Section("Add Card"){
                    VStack{
                        TextField("Enter new prompt", text: $newPrompt)
                        TextField("Enter answer of the prompt", text: $newAnswer)
                    }
                
                    Toggle("True", isOn: $answerIsTrue)
                        .onChange(of: answerIsTrue) { value in
                            answerIsFalse = !value
                        }
                
                    
                    Toggle("False", isOn: $answerIsFalse)
                        .onChange(of: answerIsFalse) { value in
                            answerIsTrue = !value
                        }
                    
                    
                    Button("Add Card"){
                        addCard()
                    }
                }
                
                Section("Current cards"){
                    ForEach(0..<cards.count, id: \.self) { index in
                        VStack(alignment:.leading){
                            Text(cards[index].prompt)
                                .font(.headline)
                            Text(cards[index].answer)
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        .padding()
                        //.multilineTextAlignment(.center)
                    }
                    .onDelete(perform: deleteCard)
                }
            }
            .navigationTitle("Edit Card")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Dismiss"){
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save"){
                        saveData()
                    }
                }
            }
            .onAppear(perform: loadData)
        }
    }
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView(saveAction: nil)
    }
}
