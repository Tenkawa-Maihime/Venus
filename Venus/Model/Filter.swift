//
//  Filter.swift
//  Venus
//
//  Created by S.C. on 2017/11/12.
//  Copyright © 2017年 Carolar. All rights reserved.
//

import Foundation

enum FilterName: String {
    case Mosaic = "Mosaic"
    case GaussianBlur = "Gaussian Blur"
    case FastGaussianBlur = "Fast Gaussian Blur"
    case IIRGaussianBlur = "IIR GaussianBlur"
}

enum FilterFunction: String {
    case Mosaic = "Mosaic"
    case GaussianBlur = "GaussianBlur"
    case FastGaussianBlurRow = "FastGaussianBlurRow"
    case FastGaussianBlurColumn = "FastGaussianBlurColumn"
    case IIRGaussianBlur = "IIRGaussianBlur"
}

struct Filter {
    
    let filterName: FilterName
    let filterFunctions: [FilterFunction]
    let minValue: Double
    let maxValue: Double
    let step: Double
    
}
