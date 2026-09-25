//
//  GeometrysExtensions.swift
//  Bezier
//
//  Created by Heyya on 2024/2/8.
//
// https://medium.com/@alladinian/making-a-bézier-curve-editor-in-swiftui-7252b04585bc

import Foundation

// Just for clarity of intention
typealias AbsolutePoint = CGPoint
typealias RelativePoint = CGPoint

//func * (lhs: CGSize, rhs: CGSize) -> CGSize {
//    .init(width: lhs.width * rhs.width, height: lhs.height * rhs.height)
//}

func * (lhs: CGSize, rhs: CGFloat) -> CGPoint {
    CGPoint(x: lhs.width * rhs, y: lhs.height * rhs)
}

func * (lhs: CGPoint, rhs: CGSize) -> CGPoint {
    .init(x: lhs.x * rhs.width, y: lhs.y * rhs.height)
}

//func - (lhs: CGPoint, rhs: CGFloat) -> CGPoint {
//    .init(x: lhs.x - rhs, y: lhs.y - rhs)
//}

func * (lhs: CGPoint, rhs: CGFloat) -> CGPoint {
    .init(x: lhs.x * rhs, y: lhs.y * rhs)
}

func / (lhs: CGPoint, rhs: CGFloat) -> CGPoint {
    .init(x: lhs.x / rhs, y: lhs.y / rhs)
}

//
//func + (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
//    .init(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
//}

func + (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
    .init(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
}

func - (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
    .init(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
}

//func / (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
//    .init(x: lhs.x / rhs.x, y: lhs.y / rhs.y)
//}

func + (lhs: CGSize, rhs: CGSize) -> CGSize {
    .init(width: lhs.width + rhs.width, height: lhs.height + rhs.height)
}

func < (lhs: CGPoint, rhs: CGPoint) -> Bool {
    return (abs(lhs.x) < abs(rhs.x) && abs(lhs.y) < abs(rhs.y))
}

func == (lhs: BezierPoint, rhs: BezierPoint) -> Bool {
    let distanceError = CGPoint(x: 0.1, y: 0.1)
    if (lhs.point - rhs.point) < distanceError && (lhs.cp1! - rhs.cp1!) < distanceError && (lhs.cp2! - rhs.cp2!) < distanceError {
        return true
    } else {
        return false
    }
}

//func / (lhs: CGSize, rhs: CGSize) -> CGSize {
//    .init(width: lhs.width / rhs.width, height: lhs.height / rhs.height)
//}


func distance(pointA: CGPoint, pointB: CGPoint) -> CGFloat {
    let deltaX = pointA.x - pointB.x
    let deltaY = pointA.y - pointB.y
    return sqrt(deltaX * deltaX + deltaY * deltaY)
}

func getSymmetricPoint(pointA: CGPoint, pointB: CGPoint) -> CGPoint {
    let deltaX = pointA.x - pointB.x
    let deltaY = pointA.y - pointB.y
    return CGPoint(x: pointB.x - deltaX, y: pointB.y - deltaY)
}

extension CGSize {
    var toPoint: CGPoint { .init(x: width, y: height) }
//    var half: CGSize { .init(width: width/2, height: height/2) }
}
//
//extension CGPoint {
//    var toSize: CGSize { .init(width: x, height: y)}
//}
