//
//  BezierPoint.swift
//  Bezier
//
//  Created by Heyya on 2024/2/8.
//

import Foundation

struct BezierPoint: Identifiable {
    let id = UUID()
    
    var point: CGPoint
    var cp1: CGPoint? = nil
    var cp2: CGPoint? = nil
    var isBinded = true
}
