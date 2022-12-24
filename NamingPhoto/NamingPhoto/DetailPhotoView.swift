//
//  DetailPhotoView.swift
//  NamingPhoto
//
//  Created by Deye Lei on 12/23/22.
//

import Foundation
import SwiftUI

struct DetailPhotoView: View {
    let item: ListItem
    
    var displayImage:Image?{
        guard let data = try? Data(contentsOf: item.savePath) else{return nil}
        guard let uiImage = UIImage(data: data) else {return nil}
        return Image(uiImage: uiImage)
    }
    
    var body: some View {
        NavigationView {
            VStack{
                displayImage?
                    .resizable()
                    .scaledToFit()
            }
            
            .navigationTitle(item.name)
        }
    }
}

struct DetailPhotoView_Previews: PreviewProvider {
    static var previews: some View {
        DetailPhotoView(item: ListItem(name: "abc", savePath: URL(filePath: "some path")))
    }
}
