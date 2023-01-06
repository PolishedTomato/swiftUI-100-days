//
//  MeView.swift
//  HotProspects
//
//  Created by Deye Lei on 12/30/22.
//

import Foundation
import SwiftUI
import CoreImage.CIFilterBuiltins

struct MeView: View {
    @State var name = "your name"
    @State var email = "your@email.com"
    @State var showScanner = false
    @State var qrCode = UIImage()
    //declare context, and a filter
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    
    func generateQrCode(from string: String) -> UIImage{
        let data = Data(string.utf8)
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
