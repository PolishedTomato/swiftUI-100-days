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
    
    @State private var showFilter = false
    @State private var filter:CIFilter = CIFilter.sepiaTone()
    let context = CIContext()//context is expensive so we only declare once
    
    func setFilter(_ filter: CIFilter){
        self.filter = filter
        loadImage()
    }
    
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
        //setting intensitykey value for this filter since it conform to CIFilter now
        //filter.setValue(Float(filterIntensity), forKey: kCIInputIntensityKey)
        
        //this is a better solution since some filter will not have some key to work with
        //by doing this, you prevent crash, and now filter work on any filterIntensity you inputed.
        let inputKeys = filter.inputKeys

        if inputKeys.contains(kCIInputIntensityKey) { filter.setValue(filterIntensity, forKey: kCIInputIntensityKey) }
        if inputKeys.contains(kCIInputRadiusKey) {
            filter.setValue(filterIntensity * 200, forKey: kCIInputRadiusKey) }
        if inputKeys.contains(kCIInputScaleKey) {
            filter.setValue(filterIntensity * 10, forKey: kCIInputScaleKey) }
        
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
                    showFilter = true
                }
                .padding()
                
                Button("Save"){
                    guard let save = saveImage else{
                        print("save failed")
                        return }
                    let saver = PhotoSaver()
                    saver.errorHandler = {
                        error in print(error.localizedDescription)
                    }
                    saver.successHandler = {
                        print("save complete!")
                    }
                    saver.savePhoto(Image: save)
                }
            }
            .navigationTitle("Instafilter")
            .sheet(isPresented: $showPhotoPicker){
                PhotoPicker(image: $pickedImage)
            }
            .confirmationDialog("Chose a filter", isPresented: $showFilter, actions: {
                Button("Crystallize") { setFilter(CIFilter.crystallize()) }
                Button("Edges") { setFilter(CIFilter.edges()) }
                Button("Gaussian Blur") { setFilter(CIFilter.gaussianBlur()) }
                Button("Pixellate") { setFilter(CIFilter.pixellate()) }
                Button("Sepia Tone") { setFilter(CIFilter.sepiaTone()) }
                Button("Unsharp Mask") { setFilter(CIFilter.unsharpMask()) }
                Button("Vignette") { setFilter(CIFilter.vignette()) }
                Button("Cancel", role: .cancel) { }
            })
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
