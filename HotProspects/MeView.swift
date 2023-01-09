//
//  MeView.swift
//  HotProspects
//
//  Created by Deye Lei on 12/30/22.
//

import Foundation
import SwiftUI
import CoreImage.CIFilterBuiltins
import CoreLocation

struct person: Codable{
    var name:String
    var email:String
    var lat: Double?
    var lon: Double?
}

struct MeView: View {
    @State var name = "your name"
    @State var email = "your@email.com"
    @State var showScanner = false
    @State var qrCode = UIImage()
    //declare context, and a filter
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    
    var locationReader = LocationReader()
    //var location: CLLocationCoordinate2D?
    
    func generateQrCode(from string: String) -> UIImage{
        
        var data = Data()
        //this code won't work with CodeScanner of hackingwithswift, unless we use a new scanner that handle data instead of string
        if let location = locationReader.location{
            do{
                data = try JSONEncoder().encode(person(name: name, email: email, lat: location.latitude.binade, lon: location.latitude.binade))
                print("used location for encode")
            }
            catch{
                print(error)
            }
        }
        else{
            do{
                data = try JSONEncoder().encode(person(name:name,email:email))
                print("didn't use location for encode")
            }
            catch{
                print(error)
            }
        }
        //let data = Data(inputString.utf8)
        //let fil = CIFilter.areaAverage()
        filter.message = data
        if let outputImage = filter.outputImage{
            if let cgImage = context.createCGImage(outputImage, from: outputImage.extent){
                return UIImage(cgImage: cgImage)
            }
        }
        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
    
    func save(savingImage: UIImage){
        
        let photoSaver = PhotoSaver()
        photoSaver.errorHandler = {
            error in print(error.localizedDescription)
        }
        
        photoSaver.successHandler = {
            print("photo save success")
        }
        photoSaver.savePhoto(Image: savingImage)
    }
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                    .textContentType(.name)
                    .font(.title)

                TextField("Email address", text: $email)
                    .textContentType(.emailAddress)
                    .font(.title)
                HStack{
                    Spacer()
                    Image(uiImage: qrCode)
                        .interpolation(.none)
                        .resizable()
                        .scaledToFit()
                    .frame(width: 200, height: 200)
                    .contextMenu{
                        Button{
                            save(savingImage: qrCode)
                        } label:{
                           Label("Save to photo", systemImage: "square.and.arrow.down")
                        }
                    }
                    Spacer()
                }
            }
            .navigationTitle("Your code")
            .onAppear{
                locationReader.requestLocation()
                qrCode = generateQrCode(from: "\(name) \n \(email)")
            }
            .onChange(of: name) { newValue in
                qrCode = generateQrCode(from: "\(newValue) \n \(email)")
            }
            .onChange(of: email) { newValue in
                qrCode = generateQrCode(from: "\(name) \n \(newValue)")
            }
        }
    }
}

struct MeView_Previews: PreviewProvider {
    static var previews: some View {
        MeView()
    }
}
