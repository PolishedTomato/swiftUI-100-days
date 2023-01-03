//
//  ImageSaver.swift
//  HotProspects
//
//  Created by Deye Lei on 1/3/23.
//
import UIKit
import Foundation

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
