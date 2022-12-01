//
//  Filter.swift
//  Instafilter
//
//  Created by Deye Lei on 12/1/22.
//
import CoreImage
import Foundation

struct Filter: Hashable{
    let name: String
    let filter: CIFilter
}
