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
    @Binding var metricUnit: Bool
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
                    
                    Section("Unit"){
                        Toggle("℃", isOn: $viewModel.choseCelsius)
                            .onChange(of: viewModel.choseCelsius) { _ in
                                viewModel.choseFahrenheit = !viewModel.choseCelsius
                            }
                        Toggle("℉", isOn: $viewModel.choseFahrenheit)
                            .onChange(of: viewModel.choseFahrenheit) { _ in
                                viewModel.choseCelsius = !viewModel.choseFahrenheit
                            }
                    }
                    
                    
                }
                
                Button("Search"){
                    Task{
                        metricUnit = viewModel.choseCelsius ? true : false
                        if viewModel.alterForm == true{
                            openWeather = await viewModel.weatherApiRequest()
                        }
                        else{
                            await viewModel.coordinateApiRequest()
                            openWeather = await viewModel.weatherApiRequest()
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
        }
    }
}

struct LocationFormView_Previews: PreviewProvider {
    static var previews: some View {
        LocationFormView(metricUnit: .constant(true), openWeather: .constant(OpenWeather(cod: "01", message: 01, cnt: 01, list: OpenWeather.WeatherForcast.sampleData, city: OpenWeather.City.sampleDate)))
    }
}
