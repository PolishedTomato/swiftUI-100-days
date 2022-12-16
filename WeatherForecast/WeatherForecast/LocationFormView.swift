//
//  LocationFormView.swift
//  WeatherForecast
//
//  Created by Deye Lei on 12/15/22.
//

import Foundation
import SwiftUI

struct LocationFormView: View {
    @State var zipCode = ""
    @State var cityName = ""
    
    @State var choseCelsius = true;
    @State var choseFahrenheit = false;
    
    @State var lat = 0.00
    @State var lon = 0.00
    
    @Binding var metricUnit: Bool
    @Binding var openWeather: OpenWeather?
    
    var cityNamePercentEncoding: String{
        cityName.trimmingCharacters(in: .whitespacesAndNewlines).capitalized.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ??  "failed"
    }
    
    var geoApiCityName:String{ "http://api.openweathermap.org/geo/1.0/direct?q=\(cityNamePercentEncoding)&limit=5&appid=4e7641da2c40729611d1770ccec6aed3"
    }


    var geoApiZipCode: String{
        "http://api.openweathermap.org/geo/1.0/zip?zip=\(zipCode)&appid=4e7641da2c40729611d1770ccec6aed3"
    }
    
    var openWeatherApi:String{
        "http://api.openweathermap.org/data/2.5/forecast?lat=\(lat)&lon=\(lon)&appid=4e7641da2c40729611d1770ccec6aed3&units=\(choseCelsius == true ? "metric" : "imperial")"
    }
    
    @State var showAlert = false
    @State var alertMessage = ""
    
    func coordinateApiRequest()async{
        if(!cityName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty){
            
            let decoder = JSONDecoder()
            
            guard let ApiURL = URL(string: geoApiCityName)else{
                showAlert = true
                alertMessage = "Invalid city name"
                return
            }
            
            guard let (JsonData,_) = try? await URLSession.shared.data(from: ApiURL) else{
                showAlert = true
                alertMessage = "Invalid URL"
                return
            }
            
            guard let data = try? decoder.decode([GeoCoding.CoordinateByCityName.GeoLocation].self, from: JsonData) else{
                showAlert = true
                alertMessage = "failed to decode"
                return
            }
            lat = data[0].lat
            lon = data[0].lon
            
        }
        else{
            let decoder = JSONDecoder()
            
            guard let ApiURL = URL(string: geoApiZipCode)else{
                showAlert = true
                alertMessage = "Invalid ZipCode"
                return
            }
            
            guard let (JsonData,_) = try? await URLSession.shared.data(from: ApiURL) else{
                showAlert = true
                alertMessage = "Invalid URL"
                return
            }
            
            guard let data = try? decoder.decode(GeoCoding.CoordinateByZipCode.self, from: JsonData) else{
                showAlert = true
                alertMessage = "failed to decode"
                return
            }
            lat = data.lat
            lon = data.lon
        }
    }
    
    func weatherApiRequest()async{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(formatter)
        
        guard let ApiURL = URL(string: openWeatherApi)else{
            showAlert = true
            alertMessage = "invaild url"
            return
        }
        
        guard let (JSONData, _) = try? await URLSession.shared.data(from: ApiURL) else{
            showAlert = true
            alertMessage = "fail to load, try again"
            return
        }
        
        do{
            self.openWeather = try decoder.decode(OpenWeather.self, from: JSONData)
            print("load success")
        }
        catch{
            print(error)
            return
        }
    }
    
    var body: some View {
        NavigationView{
            VStack{
                Form{
                    Section("City name"){
                        TextField("Please enter city name, Ex: New York", text: $cityName)
                    }
                    
                    Section("Zip code"){
                        TextField("Please enter Zip", text: $zipCode)
                    }
                    
                    Section("Degree"){
                        Toggle("℃", isOn: $choseCelsius)
                            .onChange(of: choseCelsius) { _ in
                                choseFahrenheit = false
                            }
                        Toggle("℉", isOn: $choseFahrenheit)
                            .onChange(of: choseFahrenheit) { _ in
                                choseCelsius = false
                            }
                    }
                    
                    
                }
                
                Button("Search"){
                    Task{
                        metricUnit = choseCelsius ? true : false
                        await coordinateApiRequest()
                        await weatherApiRequest()
                    }
                }
                .font(.largeTitle)
                .disabled(zipCode.isEmpty && cityName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                /*
                Text(lat.formatted())
                Text(lon.formatted())
                Text(cityName.trimmingCharacters(in: .whitespacesAndNewlines).capitalized.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "default")*/
            }
            .navigationTitle("WeatherForecast")
            .alert("Error", isPresented: $showAlert) {
                Button("Ok"){
                    
                }
            } message: {
                Text(alertMessage)
            }

        }
    }
}

struct LocationFormView_Previews: PreviewProvider {
    static var previews: some View {
        LocationFormView(metricUnit: .constant(true), openWeather: .constant(OpenWeather(cod: "01", message: 01, cnt: 01, list: OpenWeather.WeatherForcast.sampleData, city: OpenWeather.City.sampleDate)))
    }
}
