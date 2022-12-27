//
//  ContentView_DataModel.swift
//  NamingPhoto
//
//  Created by Deye Lei on 12/26/22.
//

import Foundation
import UIKit
import SwiftUI
import CoreLocation

extension ContentView{
    @MainActor class DataModel:ObservableObject{
        @Published var selectedImage: UIImage?
        @Published var text = ""
        @Published var showSheet = false
        @Published var collection: [ListItem] = []
        @Published var count = 0
        var locationFetcher = LocationFetcher()
        @Published var accessToLocation = false
        
        var fetchLocation: CLLocationCoordinate2D{
            return locationFetcher.lastKnownLocation ?? CLLocationCoordinate2D(latitude: 0, longitude: 0)
        }
        
        var displayImage: Image?{
            if let selectedImage = selectedImage{
                return Image(uiImage: selectedImage)
            }
            return nil
        }
        
        func fetchData()->[ListItem]{
            let url = FileManager.savePath.appending(component: "Collection")
            
            guard let data = try? Data(contentsOf: url) else{ return []}
            
            let decoder = JSONDecoder()
            
            guard let items = try? decoder.decode([ListItem].self, from: data) else{ return []}
            print("data retrive success")
            return items
        }
        
        func showImage(item: ListItem)->Image?{
            guard let data = try? Data(contentsOf: item.savePath) else{return nil}
            guard let uiImage = UIImage(data: data) else {return nil}
            return Image(uiImage: uiImage)
        }
        
        func saveImage(url: URL){
            guard let selectedImage = selectedImage else{return}
            
            //write img to file using jpegData
            if let jpegData = selectedImage.jpegData(compressionQuality: 0.8) {
                try? jpegData.write(to: url, options: [.atomic, .completeFileProtection])
            }
            
            let URL = FileManager.savePath.appending(component: "Collection")
            
            let encoder = JSONEncoder()
            
            guard let data = try? encoder.encode(collection) else{ return }
            
            do{
                try data.write(to: URL, options: [.atomic])
                print("save success")
            }
            catch{
                print(error)
            }
        }
        
        func onSave(_ newItem: ListItem){
            count += 1
            collection.append(newItem)
            saveImage(url: newItem.savePath)
        }
    }
}
