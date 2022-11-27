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
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
        
    }
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        //configure it so we only want image picker
        config.filter = .images

        let picker = PHPickerViewController(configuration: config)
        return picker
    }

    
}
