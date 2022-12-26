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
        guard let selectedPicker = selectedPicker else{return}
        
        //write img to file using jpegData
        if let jpegData = selectedPicker.jpegData(compressionQuality: 0.8) {
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
                                    .frame(width: 150, height: 150)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                            }
                        }

                    }
                    
                }
                .listStyle(.insetGrouped)
            }
            .sheet(isPresented: $showSheet) {
                PhotoPicker(image: $selectedPicker)
            }
            .onAppear{//place it in here so it will get call again and again when view show, initializer only call once
                collection = fetchData()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
