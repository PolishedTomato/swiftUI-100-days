//
//  ContentView.swift
//  NamingPhoto
//
//  Created by Deye Lei on 12/23/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var dataModel = DataModel()
    
    var body: some View {
        NavigationView{
            if dataModel.accessToLocation == false{
                Button("Allow read location"){
                    dataModel.locationFetcher.start()
                    dataModel.accessToLocation = true
                }
                .font(.largeTitle)
            }
            else{
                VStack{
                    Button("Search Image"){
                        dataModel.showSheet = true
                    }
                    .font(.largeTitle)
                    
                    VStack{
                        dataModel.displayImage?
                            .resizable()
                            .scaledToFit()
                        HStack{
                            Spacer()
                            TextField("Enter name", text: $dataModel.text)
                                .font(.headline)
                            Button("Add Image"){
                                let listItem = ListItem(name: dataModel.text, savePath: FileManager.savePath(offset: dataModel.count), latitude: dataModel.fetchLocation.latitude, longitude: dataModel.fetchLocation.longitude)
                                dataModel.onSave(listItem)
                            }
                            .font(.headline)
                            .disabled(dataModel.text.isEmpty || dataModel.selectedImage == nil)
                            .onTapGesture {
                                dataModel.text = ""
                            }
                            
                            Spacer()
                        }
                    }
                    
                    List{
                        ForEach(dataModel.collection, id: \.self){ listItem in
                            NavigationLink {
                                DetailPhotoView(item: listItem)
                            } label: {
                                HStack{
                                    Text("\(listItem.name)")
                                    dataModel.showImage(item: listItem)?
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 150, height: 150)
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                }
                            }
                            
                        }
                        
                    }
                    
                }
                .sheet(isPresented: $dataModel.showSheet) {
                    PhotoPicker(image: $dataModel.selectedImage)
                }
                .onAppear{//place it in here so it will get call again and again when view show, initializer only call once
                    dataModel.collection = dataModel.fetchData()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
