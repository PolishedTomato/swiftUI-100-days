//
//  ContentView.swift
//  SwiftUI Day 70
//
//  Created by Deye Lei on 12/6/22.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @StateObject private var viewModel = ViewModel()
    var body: some View {
        if viewModel.isUnlocked{
            ZStack{
                //using map will cause a error of updating state, this is a error of apple
                Map(coordinateRegion: $viewModel.mapRegion, annotationItems: viewModel.locations) { location in
                    
                    
                    MapAnnotation(coordinate: location.coordinator) {
                        VStack{
                            Text(viewModel.emojiMaker[location.emojiMarker])
                                .font(.largeTitle)
                                .padding()
                            Text(location.name)
                                .foregroundColor(.white)
                                .background(LinearGradient(colors: [.yellow, .green], startPoint: .topLeading, endPoint: .bottomTrailing))
                                .foregroundStyle(.ultraThinMaterial)
                                .clipShape(Capsule())
                                .fixedSize()
                        }
                        .onTapGesture {
                            viewModel.chosedLocation = location
                            
                        }
                    }
                }
                .ignoresSafeArea()
                
                Circle()
                    .stroke(.pink,style: StrokeStyle(lineWidth: 2))
                    .frame(width:10)
                //force it to stay at bottom right corner with spacer()
                
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button {
                            // handle the job to viewModel instead
                            viewModel.addLocation()
                        } label: {
                            Image(systemName: "plus")
                                .padding()
                                .background(.black.opacity(0.75))
                                .foregroundColor(.white)
                                .font(.title)
                                .clipShape(Circle())
                                .padding(.trailing)
                        }
                    }
                }
            }
            .sheet(item: $viewModel.chosedLocation) { location in
                DetailLocationView(location: location){
                    viewModel.update(newLocation: $0)
                }
            }
            .alert("Bio authentication failed", isPresented: $viewModel.bioAuthenticationFail) {
                Button("Ok"){
                    
                }
            } message: {
                Text("please try again")
            }

        }
        else{
            Button("unlock"){
                viewModel.authorize()
            }
            .padding()
            .background(.blue)
            .foregroundColor(.white)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
