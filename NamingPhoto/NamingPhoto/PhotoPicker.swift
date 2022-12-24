//
//  PhotoPicker.swift
//  NamingPhoto
//
//  Created by Deye Lei on 12/23/22.
//

import Foundation
import SwiftUI
import PhotosUI

struct PhotoPicker: UIViewControllerRepresentable{
    @Binding var image: UIImage?
    
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    //act as delegator for picker
    class Coordinator: NSObject, PHPickerViewControllerDelegate{
        var parent: PhotoPicker
        
        init(_ parent: PhotoPicker){
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            //
            picker.dismiss(animated: false)
            
            guard let provider = results.first?.itemProvider else {
                return }
            
            if provider.canLoadObject(ofClass: UIImage.self){
                provider.loadObject(ofClass: UIImage.self) { image, _ in
                    self.parent.image = image as? UIImage
                }
            }
        }
    }
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .images
        
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
        
    }
    
}
