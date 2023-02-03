//
//  ResortView.swift
//  SnowSeeker
//
//  Created by Deye Lei on 1/30/23.
//

import Foundation
import SwiftUI



struct MyView_Previews: PreviewProvider {
    static var previews: some View {
        ResortView(resort: Resort.example)
            .environmentObject(Favorites())
    }
}

struct ResortView: View {
    let resort: Resort
    @Environment(\.horizontalSizeClass) var sizeClass
    @Environment(\.dynamicTypeSize) var typeSize
    @EnvironmentObject var favoriteResorts : Favorites
    @State var showAlert = false
    @State var selectedFacility: Facility?
    
    var facilities: [Facility]{
        return resort.facilities.map { facility in
            Facility(name: facility)
        }
    }
    
    var body: some View {
        ScrollView {
            ZStack(alignment: .topTrailing){
                VStack(alignment: .leading, spacing: 0) {
                    Image(decorative: resort.id)
                        .resizable()
                        .scaledToFit()
                    
                    HStack{
                        if sizeClass == .compact && typeSize > .large{
                            VStack(spacing: 10){
                                SkiDetailView(resort: resort)
                            }
                            VStack(spacing: 10){
                                ResortDetailView(resort: resort)
                            }
                        }
                        else{
                            SkiDetailView(resort: resort)
                            ResortDetailView(resort: resort)
                        }
                    }
                    .padding(.vertical)
                    .background(.green
                    )
                    
                    Group {
                        Text(resort.description)
                            .padding(.vertical)
                        
                        Text("Facilities")
                            .font(.headline)
                        HStack{
                            ForEach(facilities){
                                facility in facility.icon
                                    .font(.title)
                                    .onTapGesture {
                                        showAlert = true
                                        selectedFacility = facility
                                    }
                                
                            }
                        }
                        .padding(.vertical)
                    }
                    .padding(.horizontal)
                }
                HStack{
                    Label("Like", systemImage: favoriteResorts.contains(resort) ? "heart.fill" : "heart")
                        .font(.title)
                        .foregroundColor(.red)
                        .onTapGesture {
                            if favoriteResorts.contains(resort){
                                favoriteResorts.remove(resort)
                            }
                            else{
                                favoriteResorts.add(resort)
                            }
                        }
                        .accessibilityAddTraits(.isButton)
                        .accessibilityLabel("Tap to like or unlike, currently \(favoriteResorts.contains(resort) ? "liked" : "not liked")")
                    Spacer()
                    Text("Credit by \(resort.imageCredit)")
                        .foregroundColor(.secondary)
                }
                    
            }
        }
        .navigationTitle("\(resort.name), \(resort.country)")
        .navigationBarTitleDisplayMode(.inline)
        .alert(selectedFacility?.name ?? "More infomation", isPresented: $showAlert, presenting: selectedFacility) { _ in
            
        } message: { facility in
            Text("\(facility.description)")
        }
        //presenting parameter will pass in the content closure, and also the message closure unwrapped.
    }
}


