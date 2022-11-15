//
//  AddBookView.swift
//  BookWorm
//
//  Created by Deye Lei on 11/11/22.
//

import SwiftUI
import Foundation

struct AddBookView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    @State var title = ""
    @State var author = ""
    @State var rating = 3
    @State var genre = "Fantasy"
    @State var review = ""
    
    //challenger one, prevent invalid input
    @State private var showAlert = false
    func saveAction(){
        let book = Book(context: moc)
        book.id = UUID()
        book.title = title
        book.author = author
        book.genre = genre
        book.rating = Int16(rating)
        book.review = review
        book.date = Date.now
        try? moc.save()
    }
    
    var validInput: Bool{
        if title.isEmpty || author.isEmpty{
            return false
        }
        return true
    }
    
    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
    var body: some View {
        NavigationView{
            Form{
                Section("Book's info"){
                    TextField("Enter book's title", text: $title)
                    TextField("Enter the name of author(s)", text: $author)
                    
                    Picker("Rate this book", selection: $genre) {
                        
                            ForEach(genres, id:\.self){
                                Text($0)
                                    .frame(width: 30)
                            }
                    }
                }
                /*
                Section("Rate this book"){
                    Picker("rate :", selection: $rating){
                        ForEach(0..<6){
                            Text(String($0))
                        }
                    }
                    .pickerStyle(.segmented)
                }*/
                
                Section("Leave a review"){
                    TextEditor(text: $review)
                    RatingComponentView(rating: $rating)
                }
                
                Section{
                    Button("Add"){
                        if validInput {
                            saveAction()
                            dismiss()
                        }
                        else{
                            showAlert = true
                        }
                    }
                }
            }
            .navigationTitle("Add book")
            .alert("Invalid input", isPresented: $showAlert) {
                Button("Ok"){
                    
                }
            } message: {
                Text("Book title and author can't be empty")
            }

        }
    }
}

struct AddBookView_Previews: PreviewProvider {
    static var dataController = DataController()
    static var previews: some View {
        AddBookView()
            .environment(\.managedObjectContext, dataController.container.viewContext)
    }
}
