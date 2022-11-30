//
//  PhotoSaver.swift
//  Instafilter
//
//  Created by Deye Lei on 11/29/22.
//
import SwiftUI

class PhotoSaver: NSObject{
    
    var errorHandler: ((Error)->Void)?
    var successHandler: (() ->Void)?
    
    func savePhoto(Image: UIImage){
        UIImageWriteToSavedPhotosAlbum(Image, self, #selector(saveCompleted), nil)
    }
    
    //this handler need to have specific signature
    @objc func saveCompleted(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        print("Save finished!")
    }
}
