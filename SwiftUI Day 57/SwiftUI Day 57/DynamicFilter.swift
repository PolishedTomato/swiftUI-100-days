//
//  File.swift
//  SwiftUI Day 57
//
//  Created by Deye Lei on 11/17/22.
//

import SwiftUI
import CoreData
import Foundation

struct DynamicFilter<T: NSManagedObject, Content: View>: View {
    @FetchRequest var datas: FetchedResults<T>
    
    let content: (T) -> Content
    
    var body: some View {
        VStack{
            List{
                if(datas.isEmpty){
                    Text("This is empty")
                }
                ForEach(datas, id: \.self){ data in
                    self.content(data)
                }
            }
        }
    }
    
    init(filter1: String, filter2: String ,@ViewBuilder content: @escaping (T) -> Content){
        _datas = FetchRequest<T>(sortDescriptors: [], predicate: NSPredicate(format: "%K == %@", filter1, filter2 ))
        self.content = content
    }
}

