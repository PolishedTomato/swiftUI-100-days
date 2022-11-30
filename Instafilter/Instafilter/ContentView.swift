//
//  ContentView.swift
//  Instafilter
//
//  Created by Deye Lei on 11/29/22.
//
import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI

struct ContentView: View {
    @State private var displayImage: Image?
    @State private var filterIntensity = 0.5
    @State private var pickedImage:UIImage?
    @State private var saveImage:UIImage?
    @State private var showPhotoPicker = false
    
    @State private var filter = CIFilter.sepiaTone()
    let context = CIContext()//context is expensive so we only declare once
    
    func loadImage(){
        guard let UIImage = pickedImage else {return}
        
        //displayImage = Image(uiImage: UIImage)
        //uiImage to CIiamge
        let CIImage = CIImage(image: UIImage)
        
        //feed the filter with setValue rather than .inputimage property will not crash often
        filter.setValue(CIImage, forKey: kCIInputImageKey)
        
        applyProcessing()
    }
    
    func applyProcessing() {
        filter.intensity = Float(filterIntensity)

        guard let outputImage = filter.outputImage else { return }

        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage: cgimg)
            saveImage = uiImage
            displayImage = Image(uiImage: uiImage)
        }
    }
    
    var body: some View {
        NavigationView{
            VStack{
                ZStack{
                    Rectangle()
                        .fill(.secondary)
                    
                    Button("select your image"){
                        showPhotoPicker = true
                    }
                    
                    displayImage?
                        .resizable()
                        .scaledToFit()
                    
                }
                .padding(.bottom)
                
                HStack{
                    Text("Intensity")
                    Slider(value: $filterIntensity)
                        .onChange(of: filterIntensity){
                            _ in applyProcessing()
                        }
                }
                .padding([.horizontal, .bottom])
                
                Button("Change filter"){
                    
                }
                .padding()
                
                Button("Save"){
                    guard let save = saveImage else{
                        print("save failed")
                        return }
                    let saver = PhotoSaver()
                    saver.savePhoto(Image: save)
                }
            }
            .navigationTitle("Instafilter")
            .sheet(isPresented: $showPhotoPicker){
                PhotoPicker(image: $pickedImage)
            }
            .onChange(of: pickedImage) { _ in
                loadImage()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
