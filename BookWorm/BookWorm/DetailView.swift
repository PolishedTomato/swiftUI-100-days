//
//  DetailView.swift
//  BookWorm
//
//  Created by Deye Lei on 11/14/22.
//

import SwiftUI
import CoreData
import Foundation

struct DetailView: View {
    let book: Book
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) var moc
    
    @State var showAlert = false
    
    func deleteBook(){
        moc.delete(book)
        
        try? moc.save()
    }
    
    var body: some View {
        ScrollView{
            ZStack(alignment: .bottom){
                Image(book.genre ?? "Fantasy")
                    .resizable()
                    .scaledToFit()
                    .clipShape(Capsule())
                
                Text(book.genre ?? "FANTASY")
                    .font(.caption)
                    .fontWeight(.black)
                    .padding(8)
                    .foregroundColor(.black)
                    .background(.ultraThickMaterial)
                    .clipShape(Capsule())
                    //.offset(x: 5, y: 5)
            }
            
            
            RatingComponentView(rating: .constant(Int(book.rating)))
                .padding()
            
            Text(book.review!)
                .padding()
        }
        .navigationTitle(book.title ?? "Unkown title")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Are you sure?", isPresented: $showAlert) {
            Button("Confirm", role:.destructive, action: deleteBook)
            Button("Cancel", role: .cancel, action : {})
        } message: {
            Text("Confirm your action")
        }
        .toolbar{
            ToolbarItem(placement: .destructiveAction){
                Button(role: .destructive){
                    showAlert = true
                } label:{
                    Label("Delete your book", systemImage: "trash")
                }
            }
        }
        //.preferredColorScheme(.dark)
    }
}

