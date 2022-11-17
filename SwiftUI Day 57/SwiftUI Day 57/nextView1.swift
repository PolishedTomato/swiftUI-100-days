//
//  nextView1.swift
//  SwiftUI Day 57
//
//  Created by Deye Lei on 11/16/22.
//

import SwiftUI
import Foundation

struct nextView1: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var countries: FetchedResults<County>
    
    var body: some View {
        VStack {
            List {
                ForEach(countries, id: \.self) { country in
                    Section(country.wrappedName) {
                        ForEach(country.candyArray, id: \.self) { candy in
                            Text(candy.wrappedName)
                        }
                    }
                }
            }

            Button("Add") {
                let candy1 = CandyBar(context: moc)
                candy1.name = "Mars"
                candy1.origin = County(context: moc)
                candy1.origin?.name = "UK"

                let candy2 = CandyBar(context: moc)
                candy2.name = "KitKat"
                candy2.origin = County(context: moc)
                candy2.origin?.name = "UK"

                let candy3 = CandyBar(context: moc)
                candy3.name = "Twix"
                candy3.origin = County(context: moc)
                candy3.origin?.name = "China"

                try? moc.save()
            }
        }
    }
}


