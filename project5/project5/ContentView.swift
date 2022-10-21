//
//  ContentView.swift
//  project5
//
//  Created by Deye Lei on 10/21/22.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWords : [String] = []
    @State private var RootWord = "Some word"
    @State private var newWord = ""
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showAlert = false
    
    func wordError(title: String, message: String){
        alertTitle = title
        alertMessage = message
        showAlert = true
    }
    
    func isOriginal(word: String) -> Bool{
        return !usedWords.contains(word)
    }
    
    func isPossible(word: String) -> Bool {
        var tempWord = RootWord

        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }

        return true
    }
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")

        return misspelledRange.location == NSNotFound
    }
    
    func loadwords(){
        if let fileURL = Bundle.main.url(forResource: "start", withExtension: ".txt"){
            if let fileContent = try? String(contentsOf: fileURL){
                let words = fileContent.components(separatedBy: "\n")
                RootWord = words.randomElement() ?? "SwiftUI"
                return
            }
        }
        fatalError()
    }
    
    func addNewWord(){
        let lowcase = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard lowcase.count > 0 else{
            wordError(title: "ERROR", message: "word length can't be zero")
            return
        }
        
        guard isOriginal(word: lowcase) else{
            wordError(title: "You enter this word already!", message: "Enter a different word pls")
            return
        }
        
        guard isReal(word: lowcase) else {
            wordError(title: "Word not recognized", message: "You can't just make them up, you know! \(newWord)")
            return
        }
        
        guard isPossible(word: lowcase) else{
            wordError(title: "Error", message: "it isn't possible to construct this word out of selected word")
            return
        }
        withAnimation {
            usedWords.insert(lowcase, at: 0)
        }
        
        newWord = ""
    }
    var body: some View {
        NavigationView{
            List {
                Section("Enter your new word"){
                    TextField("What word have you in mind?", text: $newWord)
                        .textInputAutocapitalization(.never)
                }
                Section("Previous words"){
                    ForEach(usedWords, id: \.self) {
                        Label("\($0)", systemImage: "\($0.count).circle")
                    }
                }
            }
            .navigationTitle("\(RootWord)")
        }
        .onSubmit(addNewWord)
        .onAppear(perform: {loadwords()})
        .alert(alertTitle, isPresented: $showAlert) {
            Button("Ok", role: .cancel){}
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
