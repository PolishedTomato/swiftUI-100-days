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
    @State private var radiusIntensity = 0.0
    @State private var scaleIntensity = 0.0
    @State private var pickedImage:UIImage?
    @State private var saveImage:UIImage?
    @State private var showPhotoPicker = false
    
    @State private var showFilter = false
    @State private var filter:CIFilter = CIFilter.sepiaTone()
    let context = CIContext()//context is expensive so we only declare once
    /*
     
     Button("Crystallize") { setFilter(CIFilter.crystallize()) }
     Button("Edges") { setFilter(CIFilter.edges()) }
     Button("Gaussian Blur") { setFilter(CIFilter.gaussianBlur()) }
     Button("Pixellate") { setFilter(CIFilter.pixellate()) }
     Button("Sepia Tone") { setFilter(CIFilter.sepiaTone()) }
     Button("Unsharp Mask") { setFilter(CIFilter.unsharpMask()) }
     Button("Vignette") { setFilter(CIFilter.vignette()) }
     //three new filters
     Button("Area MinMax") {setFilter(CIFilter.areaMinMax())}
     Button("Invert Color"){setFilter(CIFilter.colorInvert())}
     Button("Monochrome"){setFilter(CIFilter.colorMonochrome())}
     */
    @State private var cur_filter: Filter = Filter(name: "Sepia Tone", filter: CIFilter.sepiaTone())
    let filters = [
        Filter(name: "Crystallize", filter: CIFilter.crystallize()),
        Filter(name: "Edges", filter: CIFilter.edges()),
        Filter(name: "Gaussian Blur", filter: CIFilter.gaussianBlur()),
        Filter(name: "Pixellate", filter: CIFilter.pixellate()),
        Filter(name: "Sepia Tone", filter: CIFilter.sepiaTone()),
        Filter(name: "Unsharp Mask", filter: CIFilter.unsharpMask()),
        Filter(name: "Vignette", filter: CIFilter.vignette()),
        Filter(name: "Area MinMax", filter: CIFilter.areaMinMax()),
        Filter(name: "Invert Color", filter: CIFilter.colorInvert()),
        Filter(name: "Monochrome", filter: CIFilter.colorMonochrome())
    ]
    
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
            filter.setValue(radiusIntensity * 200, forKey: kCIInputRadiusKey) }
        if inputKeys.contains(kCIInputScaleKey) {
            filter.setValue(scaleIntensity * 10, forKey: kCIInputScaleKey) }
        
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
                
                //challenge two, more sliders
                HStack{
                    Text("Radius")
                    Slider(value: $radiusIntensity)
                        .onChange(of: radiusIntensity){
                            _ in applyProcessing()
                        }
                }
                .padding([.horizontal, .bottom])
                
                HStack{
                    Text("Scale")
                    Slider(value: $scaleIntensity)
                        .onChange(of: scaleIntensity){
                            _ in applyProcessing()
                        }
                }
                .padding([.horizontal, .bottom])
                
                Button("Change filter"){
                    showFilter = true
                    
                }
                .padding()
                /*
                Picker("Select your filter", selection: $cur_filter) {
                    ForEach(filters, id:\.self) { filter in
                        Button(filter.name){
                            cur_filter = filter
                            loadImage()
                        }
                        .tag(filter)
                    }
                }*/
                
                //challenge 1, save button disable when on image picked by user
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
                .disabled(pickedImage == nil)
            }
            .navigationTitle("Instafilter")
            .sheet(isPresented: $showPhotoPicker){
                PhotoPicker(image: $pickedImage)
            }
            .confirmationDialog("Chose a filter", isPresented: $showFilter, actions: {
                
                Group{
                    Button("Crystallize") { setFilter(CIFilter.crystallize()) }
                    Button("Edges") { setFilter(CIFilter.edges()) }
                    Button("Gaussian Blur") { setFilter(CIFilter.gaussianBlur()) }
                    Button("Pixellate") { setFilter(CIFilter.pixellate()) }
                    Button("Sepia Tone") { setFilter(CIFilter.sepiaTone()) }
                    Button("Unsharp Mask") { setFilter(CIFilter.unsharpMask()) }
                    Button("Vignette") { setFilter(CIFilter.vignette()) }
                    //three new filters
                    Button("Area MinMax") {setFilter(CIFilter.areaMinMax())}
                    Button("Invert Color"){setFilter(CIFilter.colorInvert())}
                    Button("Monochrome"){setFilter(CIFilter.colorMonochrome())}
                }
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
