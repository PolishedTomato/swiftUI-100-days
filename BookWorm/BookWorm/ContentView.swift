//
//  ContentView.swift
//  BookWorm
//
//  Created by Deye Lei on 11/11/22.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) private var moc
    @FetchRequest(sortDescriptors: [SortDescriptor(\.title)]) var books: FetchedResults<Book>
    
    @State private var showAddScreen = false;
    
    
    func deleteBooks (at offSets: IndexSet){
        for offset in offSets{
            let book = books[offset]
            moc.delete(book)
        }
        //save the context
        try? moc.save()
    }
    var body: some View {
        NavigationView {
            List {
                ForEach(books) { book in
                    NavigationLink {
                        DetailView(book: book)
                    } label: {
                        HStack {
                            EmojiRatingView(rating: book.rating)
                                .font(.largeTitle)

                            VStack(alignment: .leading) {
                                Text(book.title ?? "Unknown Title")
                                    .font(.headline)
                                Text(book.author ?? "Unknown Author")
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                    
                }
                .onDelete(perform: deleteBooks)
            }
                .navigationTitle("Bookworm")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            showAddScreen.toggle()
                        } label: {
                            Label("Add Book", systemImage: "plus")
                        }
                    }
                    
                    ToolbarItem(placement: .navigationBarLeading){
                        EditButton()
                    }
                }
                .sheet(isPresented: $showAddScreen) {
                    AddBookView()
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var dataController = DataController()
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, dataController.container.viewContext)
    }
}
