//
//  Filter.swift
//  Instafilter
//
//  Created by Deye Lei on 12/1/22.
//
import CoreImage
import Foundation


enum Filters: String, Identifiable, CaseIterable{
    case Crystallize, Edges, GaussianBlur, Pixellate, SepiaTone, UnsharpMask, Vignette, AreaMinMax, InvertColor, Monochrome
    var id: Self{self}
    }
