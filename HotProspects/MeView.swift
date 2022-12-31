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
    //declare context, and a filter
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    
    func generateQrCode(from string: String) -> UIImage{
        let data = Data(string.utf8)
        
        filter.message = data
        if let outputImage = filter.outputImage{
            if let cgImage = context.createCGImage(outputImage, from: outputImage.extent){
                return UIImage(cgImage: cgImage)
            }
        }
        return UIImage(systemName: "xmark.circle") ?? UIImage()
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
                    Image(uiImage: generateQrCode(from: "\(name) \n \(email)"))
                        .interpolation(.none)
                        .resizable()
                        .scaledToFit()
                    .frame(width: 200, height: 200)
                    Spacer()
                }
                
                    
            }
            .navigationTitle("Your code")
        }
    }
}

struct MeView_Previews: PreviewProvider {
    static var previews: some View {
        MeView()
    }
}
