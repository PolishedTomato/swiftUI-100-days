//
//  ContentView.swift
//  SwiftUI Day 53
//
//  Created by Deye Lei on 11/10/22.
//

import SwiftUI

struct ContentView: View {
    //Broken down, that creates a fetch request with no sorting, and places it into a property called students that has the the type FetchedResults<Student>.
    @FetchRequest(sortDescriptors: []) var students: FetchedResults<Student>

    //Let me back up a little, because this matters. When we defined the “Student” entity, what actually happened was that Core Data created a class for us that inherits from one of its own classes: NSManagedObject. We can’t see this class in our code, because it’s generated automatically when we build our project, just like Core ML’s models. These objects are called managed because Core Data is looking after them: it loads them from the persistent container and writes their changes back too.
    
    //All our managed objects live inside a managed object context, one of which we created earlier. Placing it into the SwiftUI environment meant that it was automatically used for the @FetchRequest property wrapper – it uses whatever managed object context is available in the environment.
    @Environment(\.managedObjectContext) var moc
    @State var y = DateComponents()
    func something() -> Date{
        var x = DateComponents()
        x.hour = 8
        x.minute = 30
        return Calendar.current.date(from: x)!
    }
    
    @AppStorage("Notes") var notes = ""
    var body: some View {
        NavigationView {
            VStack {
                List(students) { student in
                    Text(student.name ?? "Unknown")
                }
                
                Button("Add") {
                    let firstNames = ["Ginny", "Harry", "Hermione", "Luna", "Ron"]
                    let lastNames = ["Granger", "Lovegood", "Potter", "Weasley"]

                    let chosenFirstName = firstNames.randomElement()!
                    let chosenLastName = lastNames.randomElement()!
                    
                    //generate a Student class using core data
                    let student = Student(context: moc)
                    //directly modify this class
                    student.id = UUID()
                    student.name = "\(chosenFirstName) \(chosenLastName)"
                    
                    try? moc.save()

                }
            }
            .navigationTitle("students")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static private var dataController = DataController()
    
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, dataController.container.viewContext)
    }
}
