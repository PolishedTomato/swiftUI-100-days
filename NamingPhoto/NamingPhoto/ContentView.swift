//
//  ContentView.swift
//  NamingPhoto
//
//  Created by Deye Lei on 12/23/22.
//

import SwiftUI

struct ContentView: View {
    var displayImage: Image?{
        if let selectedPicker = selectedPicker{
            return Image(uiImage: selectedPicker)
        }
        return nil
    }
    
    @State var selectedPicker: UIImage?
    @State var text = ""
    @State var showSheet = false
    @State var collection: [ListItem] = []
    
    @State var count = 0
    
    func showImage(item: ListItem)->Image?{
        guard let data = try? Data(contentsOf: item.savePath) else{return nil}
        guard let uiImage = UIImage(data: data) else {return nil}
        return Image(uiImage: uiImage)
    }
    
    func saveImage(url: URL){
        guard let selectedPicker = selectedPicker else{return}
        
        //write img to file using jpegData
        if let jpegData = selectedPicker.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: url, options: [.atomic, .completeFileProtection])
        }
    }
    
    var body: some View {
        NavigationView{
            VStack{
                Button("Search Image"){
                    showSheet = true
                }
                .font(.largeTitle)
                
                VStack{
                    displayImage?
                        .resizable()
                        .scaledToFit()
                    HStack{
                        Spacer()
                        TextField("Enter name", text: $text)
                            .font(.headline)
                        Button("Add Image"){
                            let listItem = ListItem(name: text, savePath: FileManager.savePath(offset: count))
                            count += 1
                            collection.append(listItem)
                            saveImage(url: listItem.savePath)
                        }
                        .font(.headline)
                        Spacer()
                    }
                }
                
                List{
                    ForEach(collection, id: \.self){ listItem in
                        NavigationLink {
                            DetailPhotoView(item: listItem)
                        } label: {
                            HStack{
                                Text("\(listItem.name)")
                                showImage(item: listItem)?
                                    .resizable()
                                    .scaledToFit()
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                            }
                        }

                    }
                }
            }
            .sheet(isPresented: $showSheet) {
                PhotoPicker(image: $selectedPicker)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
