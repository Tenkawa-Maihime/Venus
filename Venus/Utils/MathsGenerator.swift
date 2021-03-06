//
//  MathsGenerator.swift
//  Venus
//
//  Created by Theresa on 2017/11/16.
//  Copyright © 2017年 Carolar. All rights reserved.
//

import Foundation

// float to double for increase precision
class MathsGenerator {
    
    // 2维高斯矩阵
    class func Gaussian2DMatrix(radius: Float) -> [Float] {
        let radius = Int(radius)
        let length = (radius * 2 + 1) * (radius * 2 + 1)
        
        var sum: Double = 0
        var counter: Int = 0
        
        let sigma: Double = (Double(radius) * 2 + 1) / 2
        let coe = 1 / 2 / Double.pi / pow(sigma, 2)
        let indexcoe = -1 / 2 / pow(sigma, 2)
        
        var doubleMatrix: [Double] = Array(repeating: 0, count: length)
        
        for x in (-radius)...radius {
            for y in (-radius)...radius {
                let ep: Double = Double(x*x + y*y) * indexcoe
                let res: Double = coe * exp(ep)
                sum += res
                doubleMatrix[counter] = res
                counter += 1
            }
        }
        return MathsGenerator.normalization(matrix: doubleMatrix, sum: sum)
    }
    
    // 1维高斯矩阵
    class func Gaussian1DMatrix(radius: Float) -> [Float] {
        let radius = Int(radius)
        let length = radius * 2 + 1
        
        var sum: Double = 0
        var counter: Int = 0
        
        let sigma: Double = (Double(radius) * 2 + 1) / 2
        let coe = 1 / sqrt(2 * Double.pi) / sigma
        let indexcoe = -1 / 2 / pow(sigma, 2)
        
        var doubleMatrix: [Double] = Array(repeating: 0, count: length)
        
        for x in stride(from: -radius, through: radius, by: 1) {
            let ep: Double = pow(Double(x), 2) * indexcoe
            let res: Double = coe * exp(ep)
            sum = sum + res
            doubleMatrix[counter] = res
            counter += 1
        }
        return MathsGenerator.normalization(matrix: doubleMatrix, sum: sum)
    }
    
    // 2维空间域矩阵
    class func Spatial2DMatrix(radius: Float, sigma: Float) -> [Float] {
        var floatMatrix = [Float]()
        let coeD = -0.5 / pow(sigma, 2)
        let radius = Int(radius)
        
        for x in (-radius)...radius {
            for y in (-radius)...radius {
                floatMatrix.append(exp(Float(x*x + y*y) * coeD))
            }
        }
        return floatMatrix
    }
    
    // 向量化
    class func normalization(matrix: [Double], sum: Double) -> [Float] {
        var outputMatrix = [Float]()
        for i in matrix {
            outputMatrix.append(Float(i / sum))
        }
        return outputMatrix
    }
    
}
