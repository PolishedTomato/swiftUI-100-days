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
    //string interpolation for challenge one
    init(filter1: String, filter2: String ,predicate: predicates, MysortDescriptors: [SortDescriptor<T>], @ViewBuilder content: @escaping (T) -> Content){
        //switch case for challenge two
        var p:String
        switch predicate{
        case .beginswith:
            p = "BEGINSWITH"
        case .equal:
            p = "=="
        case .smaller:
            p = "<"
        case .bigger:
            p = ">"
        }
        _datas = FetchRequest<T>(sortDescriptors: MysortDescriptors, predicate: NSPredicate(format: "%K \(p) %@", filter1, filter2 ))
        self.content = content
    }
}

