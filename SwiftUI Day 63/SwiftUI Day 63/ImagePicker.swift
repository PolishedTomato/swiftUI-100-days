//
//  ImagePicker.swift
//  SwiftUI Day 63
//
//  Created by Deye Lei on 11/27/22.
//

import PhotosUI
import SwiftUI
import UIKit

struct ImagePicker: UIViewControllerRepresentable{
    @Binding var image: UIImage?
    
    
    //delegate that perform to user action
    class Coordinator: NSObject, PHPickerViewControllerDelegate{
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            // Tell the picker to go away
            picker.dismiss(animated: true)

            // Exit if no selection was made
            guard let provider = results.first?.itemProvider else { return }

            // If this has an image we can use, use it
            if provider.canLoadObject(ofClass: UIImage.self) {
                provider.loadObject(ofClass: UIImage.self) { image, _ in
                    self.parent.image = image as? UIImage
                }
            }
        }
        
        var parent: ImagePicker

        //so this coordinator will modify the binding value of picker directy
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
    }
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
        
    }
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        //configure it so we only want image picker
        config.filter = .images

        let picker = PHPickerViewController(configuration: config)
        //since swift automatically call makeCoordinator() and use it, we can access it in context parameter
        picker.delegate = context.coordinator
        return picker
    }

    
}
