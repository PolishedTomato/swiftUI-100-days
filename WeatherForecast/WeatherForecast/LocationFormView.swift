//
//  LocationFormView.swift
//  WeatherForecast
//
//  Created by Deye Lei on 12/15/22.
//

import Foundation
import SwiftUI

struct LocationFormView: View {
    @StateObject var viewModel = ViewModel()
    @Binding var unit: Units
    @Binding var openWeather: OpenWeather?
    
    func onComplete(openWeather: OpenWeather)->Void{
        self.openWeather = openWeather
    }
    
    var body: some View {
        NavigationView{
            VStack{
                Form{
                    if viewModel.alterForm == false{
                        Section("City name"){
                            TextField("Please enter city name, Ex: New York", text: $viewModel.cityName)
                        }
                        .accessibilityHint("Enter either city name or zip code to enable search, or switch to other form")
                        
                        Section("Zip code"){
                            TextField("Please enter Zip", text: $viewModel.zipCode)
                        }
                        .accessibilityHint("Enter either city name or zip code to enable search, or switch to other form")
                    }
                    else{
                        Section("GPS Coordinates Lat/Lon"){
                            TextField("Latitude", value: $viewModel.lat, formatter: viewModel.numberFormatter)
                                .keyboardType(.decimalPad)
                                .accessibilityLabel("Latitude")
                            
                            TextField("Longitude", value: $viewModel.lon, formatter: viewModel.numberFormatter)
                                .keyboardType(.decimalPad)
                                .accessibilityLabel("Longitude")
                                
                        }
                    }
                    
                    Picker("Unit", selection: $unit) {
                        ForEach(Units.allCases) { u in
                            Text(u.rawValue.capitalized)
                        }
                    }
                }
                
                Button("Search"){
                    viewModel.unit = unit
                    Task{
                        if viewModel.alterForm == true{
                            openWeather = await viewModel.weatherApiRequest()
                        }
                        else{
                            await viewModel.coordinateApiRequest()
                            if viewModel.locations.count == 1{
                                viewModel.lat = viewModel.locations[0].lat
                                viewModel.lat = viewModel.locations[0].lon
                                openWeather = await viewModel.weatherApiRequest()
                            }
                            else if viewModel.locations.count == 0{
                                viewModel.alertMessage = "Invalid city name"
                                viewModel.showAlert = true
                            }
                            else{
                                viewModel.showDialog = true
                            }
                        }
                    }
                }
                .font(.largeTitle)
                .disabled(viewModel.disableCondition)
                
                /*
                Text(lat.formatted())
                Text(lon.formatted())
                Text(cityName.trimmingCharacters(in: .whitespacesAndNewlines).capitalized.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "default")*/
            }
            .navigationTitle("WeatherForecast")
            .alert("Error", isPresented: $viewModel.showAlert) {
                Button("Ok"){
                    
                }
            } message: {
                Text(viewModel.alertMessage)
            }
            .toolbar {
                ToolbarItem {
                    Button("Change form"){
                        viewModel.alterForm.toggle()
                    }
                }
            }
            .customConfirmationDialog(isPresented: $viewModel.showDialog) {
                ForEach(viewModel.locations, id: \.self){ location in
                    Button{
                        viewModel.lat = location.lat
                        viewModel.lon = location.lon
                        viewModel.showDialog = false
                        Task{
                            openWeather = await viewModel.weatherApiRequest()
                        }
                    } label: {
                        HStack{
                            Image(location.country.lowercased())
                                .resizable()
                                .frame(width: 100, height: 50)
                            VStack{
                                Text("\(viewModel.countryName(countryCode: location.country))")
                                    .font(.headline.bold())
                                
                                VStack(alignment: .leading){
                                    Text("lat: \(location.lat.formatted())")
                                    Text("lon: \(location.lon.formatted())")
                                }
                                .foregroundColor(.secondary)
                            }
                        }
                    }
                    Divider()
                }
            }
        }
    }
}

struct LocationFormView_Previews: PreviewProvider {
    static var previews: some View {
        LocationFormView(unit: .constant(.imperial), openWeather: .constant(OpenWeather(cod: "01", message: 01, cnt: 01, list: OpenWeather.WeatherForcast.sampleData, city: OpenWeather.City.sampleDate)))
    }
}

extension View{
    func customConfirmationDialog<T: View>(isPresented: Binding<Bool>, @ViewBuilder action: @escaping ()->T) -> some View{
        return self.modifier(ConfirmationDialogModifier(isPresented: isPresented, action: action))
    }
}

//To pass a closure into other struct, it is best to use generic constraint in View
//Since we can’t use the some View opaque return type for stored properties (they’re not returning anything, after all), and since we’re no longer dealing with a predefined number of views that can be combined using ViewBuilder
//By using generic parameter list and where clause constraint, we are able to avoid any View type
struct ConfirmationDialogModifier<T> : ViewModifier where T : View{
    @Binding var isPresented: Bool
    @ViewBuilder let action: ()-> T
    
    func body(content: Content)->some View{
        ZStack{
            content
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            ZStack(alignment: .bottom){
                if isPresented{
                    Color.primary
                        .opacity(0.2)
                        .ignoresSafeArea()
                        .transition(.opacity)
                        .onTapGesture {
                            isPresented = false
                        }
                }
                
                if isPresented{
                    VStack{
                        GroupBox{
                            Text("Multiple result occured")
                                .frame(maxWidth: .infinity, alignment: .center)
                        }
                        GroupBox{
                            action()
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
        
                        GroupBox {
                            Button("Cancel", role: .cancel){
                                isPresented = false
                            }
                            .bold()
                            .frame(maxWidth: .infinity, alignment: .center)
                        }
                    }
                    .padding(10)
                    .font(.title3)
                }
            }
            .animation(.easeIn, value: isPresented)
            
        }
    }
}
