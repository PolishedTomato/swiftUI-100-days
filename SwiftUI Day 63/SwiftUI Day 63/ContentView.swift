//
//  ContentView.swift
//  SwiftUI Day 63
//
//  Created by Deye Lei on 11/27/22.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct ContentView: View {
    @State var myImage: Image?
    @State private var showSheet = false
    
    @State private var inputImage: UIImage?
    var body: some View {
        VStack {
            myImage?
                .resizable()
                .scaledToFit()
            Button("Show picker"){
                showSheet = true
            }
            
            Button("Save Image") {
                guard let inputImage = inputImage else { return }

                let imageSaver = ImageSaver()
                imageSaver.writeToPhotoAlbum(image: inputImage)
            }
        }
        .onAppear(perform: loadImage)
        .sheet(isPresented: $showSheet){
            ImagePicker(image: $inputImage)
        }
        .onChange(of: inputImage){
            _ in loadImage1()
        }
    }
    
    func loadImage1() {
        guard let inputImage = inputImage else { return }
        myImage = Image(uiImage: inputImage)
    }
    
    func loadImage(){
        guard let inputImage = UIImage(named: "dog") else { return }
        //CIImage is the image type work with core image
        let beginImage = CIImage(image: inputImage)
        
        
        let context = CIContext()
        /*
        let currentFilter = CIFilter.crystallize()
        
        //feed the filter with our CI image, and intensity argument
        currentFilter.inputImage = beginImage
        currentFilter.radius = 100
        */
        
        //a older api which use keys to set parameter like userdefault
        //its benefit is it will work for any filter because won't need to know if this filter actaully have this key, useful for experiment
        let currentFilter = CIFilter.twirlDistortion()
        currentFilter.inputImage = beginImage

        let amount = 1.0

        let inputKeys = currentFilter.inputKeys

        if inputKeys.contains(kCIInputIntensityKey) {
            currentFilter.setValue(amount, forKey: kCIInputIntensityKey) }
        if inputKeys.contains(kCIInputRadiusKey) { currentFilter.setValue(amount * 200, forKey: kCIInputRadiusKey) }
        if inputKeys.contains(kCIInputScaleKey) { currentFilter.setValue(amount * 10, forKey: kCIInputScaleKey) }
        // get a CIImage from our filter or exit if that fails
        guard let outputImage = currentFilter.outputImage else { return }

        // attempt to get a CGImage from our CIImage
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            // convert that to a UIImage
            let uiImage = UIImage(cgImage: cgimg)

            // and convert that to a SwiftUI image
            myImage = Image(uiImage: uiImage)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
