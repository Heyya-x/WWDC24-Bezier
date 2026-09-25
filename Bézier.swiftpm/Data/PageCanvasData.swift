//
//  PageCanvasData.swift
//  Bezier
//
//  Created by Heyya on 2024/2/20.
//

import Foundation
import SwiftUI

class PageCanvasData: ObservableObject {
    
    // Global
    @Published var canvasTitle = ""
    @Published private var childWillChange: Void = ()
    
    // Chapter 0
    
    // Chapter 1 - Section 0
    // Chapter 1 - Section 1
    @Published var showMovePoint3 = false
    @Published var showQuadraticCurve = false
    // Chapter 1 - Section 2
    @Published var showMovePoint4AndPoint5 = false
    @Published var showMovePoint6 = false
    @Published var showCubicCurve = false
    @Published var showMore = false {
        willSet {
            objectWillChange.send()
        }
    }
    @Published var showOtherPoints = true {
        willSet {
            objectWillChange.send()
        }
    }
    @Published var showResult = false {
        willSet {
            objectWillChange.send()
        }
    }
    
    // Chapter 2 - Section 1
    
    @Published var templateCurve = [[BezierPoint]]()
    @Published var goalBezierPointQueue = [BezierPoint]()
    
    @Published var leaf: [[CGPoint]] = [
        [CGPoint(x: 0.651, y: 0.077), CGPoint(x: 0.658, y: 0.125), CGPoint(x: 0.610, y: 0.079)],
        [CGPoint(x: 0.533, y: 0.138), CGPoint(x: 0.556, y: 0.112), CGPoint(x: 0.510, y: 0.164)],
        [CGPoint(x: 0.493, y: 0.260), CGPoint(x: 0.483, y: 0.214), CGPoint(x: 0.533, y: 0.267)],
        [CGPoint(x: 0.609, y: 0.204), CGPoint(x: 0.584, y: 0.233), CGPoint(x: 0.634, y: 0.175)]
    ]
    @Published var apple: [[CGPoint]] = [
        [CGPoint(x: 0.796, y: 0.348), CGPoint(x: 0.796, y: 0.348), CGPoint(x: 0.742, y: 0.272)],
        [CGPoint(x: 0.638, y: 0.270), CGPoint(x: 0.661, y: 0.270), CGPoint(x: 0.578, y: 0.270)],
        [CGPoint(x: 0.493, y: 0.309), CGPoint(x: 0.528, y: 0.309), CGPoint(x: 0.458, y: 0.309)],
        [CGPoint(x: 0.364, y: 0.274), CGPoint(x: 0.416, y: 0.274), CGPoint(x: 0.265, y: 0.274)],
        [CGPoint(x: 0.164, y: 0.511), CGPoint(x: 0.164, y: 0.356), CGPoint(x: 0.164, y: 0.608)],
        [CGPoint(x: 0.247, y: 0.776), CGPoint(x: 0.207, y: 0.720), CGPoint(x: 0.287, y: 0.832)],
        [CGPoint(x: 0.371, y: 0.877), CGPoint(x: 0.321, y: 0.877), CGPoint(x: 0.421, y: 0.877)],
        [CGPoint(x: 0.503, y: 0.845), CGPoint(x: 0.441, y: 0.845), CGPoint(x: 0.565, y: 0.845)],
        [CGPoint(x: 0.634, y: 0.877), CGPoint(x: 0.580, y: 0.877), CGPoint(x: 0.688, y: 0.877)],
        [CGPoint(x: 0.758, y: 0.778), CGPoint(x: 0.724, y: 0.827), CGPoint(x: 0.796, y: 0.722)],
        [CGPoint(x: 0.813, y: 0.664), CGPoint(x: 0.813, y: 0.664), CGPoint(x: 0.813, y: 0.664)],
        [CGPoint(x: 0.706, y: 0.503), CGPoint(x: 0.706, y: 0.622), CGPoint(x: 0.706, y: 0.401)]
    ]
    
    // Chapter 3
    @Published var speedStartPoint = BezierPoint(point: CGPoint(x: 0, y: 1), cp2: CGPoint(x: 0.5, y: 0.7)) {
        willSet {
            objectWillChange.send()
        }
    }
    @Published var speedEndPoint = BezierPoint(point: CGPoint(x: 1, y: 0), cp1: CGPoint(x: 0.5, y: 0.3)) {
        willSet {
            objectWillChange.send()
        }
    }
    @Published var speedBoardGeometry = CGSize.zero
}
