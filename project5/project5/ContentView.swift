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
    @State private var score = 0
    
    private let rules = """
                        Guess a word from provided word.
                        1, the word enter must be at least have three letters.
                        2, it can't be the same word.
                        3, word you input must be valid.
                        4, you can only use each letter for maximum once
                        5, if you make a valid word, the length of your word will added to your score.
                        """
    
    //disallow word shorter than three letter or same as the rootword
    func challengeOne()->Bool{
        if(newWord.count < 3 || newWord == RootWord){
            return false
        }
        return true
    }
    
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
        
        guard challengeOne() else{
            wordError(title: "Challenge one error", message: "word must have length of three or greater, and can't be the same word")
            return
        }
        withAnimation {
            usedWords.insert(lowcase, at: 0)
        }
        score += lowcase.count
        newWord = ""
    }
    var body: some View {
        NavigationView{
            List {
                Section("Enter your new word"){
                    TextField("What word have you in mind?", text: $newWord)
                        .textInputAutocapitalization(.never)
                }
                Section{
                    ZStack{
                        RadialGradient(stops: [.init(color: .yellow, location: 0.15), .init(color: .green, location: 0.5)], center: .center, startRadius: 20, endRadius: 200)
                            .padding(-50)
                        
                        Text("\(score)")
                            .foregroundColor(.white)
                            .font(.headline.bold())
                    }
                } header: {
                    HStack{
                        Text("Your scores ⛳️")
                            .foregroundColor(.green)
                            .font(.headline.bold())
                        Spacer()
                        NavigationLink {
                            Text(rules)
                        } label: {
                            Image(systemName: "questionmark.diamond.fill")
                        }

                    }
                }
                Section("Previous words"){
                    ForEach(usedWords, id: \.self) {
                        Label("\($0)", systemImage: "\($0.count).circle")
                    }
                }
            }
            .navigationTitle("\(RootWord)")
            .toolbar {
                ToolbarItem {
                    Button("Start Game"){
                        loadwords()
                        usedWords = []
                    }
                }
            }
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
