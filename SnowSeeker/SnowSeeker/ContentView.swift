//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Deye Lei on 1/30/23.
//

import SwiftUI

struct ContentView: View {
    let resorts: [Resort] = Bundle.main.decode("resorts.json")
    
    @State var searchString = ""
    
    var filterResorts: [Resort]{
        if searchString.isEmpty{
            return resorts
        }
        else{
            return resorts.filter{
                $0.name.localizedCaseInsensitiveContains(searchString)
            }
        }
    }
    
    var body: some View {
        NavigationView {
            List(filterResorts) { resort in
                NavigationLink {
                    ResortView(resort: resort)
                } label: {
                    Image(resort.country)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 40, height: 25)
                        .clipShape(
                            RoundedRectangle(cornerRadius: 5)
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(.black, lineWidth: 1)
                        )
                    
                    VStack(alignment: .leading) {
                        Text(resort.name)
                            .font(.headline)
                        Text("\(resort.runs) runs")
                            .foregroundColor(.secondary)
                    }
                }
            }
            .searchable(text: $searchString, prompt: "search a resort")
            .navigationTitle("Resorts")
            //secondary view, will should by default when switch to landscape mode
            WelcomeView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//we can apply this modifier to navigationView, so that it will back to portrait behavior instead of having this slide bar behavior
extension View {
    @ViewBuilder func phoneOnlyStackNavigationView() -> some View {
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.navigationViewStyle(.stack)
        } else {
            self
        }
    }
}
