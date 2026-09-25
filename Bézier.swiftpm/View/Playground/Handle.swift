//
//  Handle.swift
//  Bezier
//
//  Created by Heyya on 2024/2/8.
//

import SwiftUI

let handlePointSize: CGFloat = 16

struct HandlePoint: View {
    @EnvironmentObject var canvasData: PageCanvasData
    
    @Binding var bezierPoint: BezierPoint
    private let size: CGFloat = handlePointSize
    var color = Color.white
    var insideColor = Color.black

    var distanceError: CGFloat = 30
    
    var moveGesture: some Gesture {
        DragGesture(minimumDistance: 0)
            .onChanged { value in
                var goalPoint = value.location
                
                if !canvasData.goalBezierPointQueue.isEmpty && distance(pointA: goalPoint, pointB: canvasData.goalBezierPointQueue.first!.point) < distanceError {
                    goalPoint = canvasData.goalBezierPointQueue.first!.point
                }
                
                let deltaPoint = bezierPoint.point - goalPoint
                if bezierPoint.cp1 != nil {
                    bezierPoint.cp1 = bezierPoint.cp1! - deltaPoint
                }
                if bezierPoint.cp2 != nil {
                    bezierPoint.cp2 = bezierPoint.cp2! - deltaPoint
                }
                bezierPoint.point = goalPoint
            }
            .onEnded { _ in
                if !canvasData.goalBezierPointQueue.isEmpty && bezierPoint == canvasData.goalBezierPointQueue.first! {
                    canvasData.goalBezierPointQueue.removeFirst()
                }
            }
    }
    
    var body: some View {
        Circle()
            .foregroundColor(insideColor)
            .frame(width: size, height: size)
            .overlay {
                Circle()
                    .stroke(color, lineWidth: 2)
            }
            .position(bezierPoint.point)
            .gesture(moveGesture)
    }
}

struct HandleControlPoint: View {
    @EnvironmentObject var canvasData: PageCanvasData
    
    @Binding var bezierPoint: BezierPoint
    var status: Int
    var color = Color.white
    var insideColor = Color.black
    
    var distanceError: CGFloat = 30
    
    private let size: CGFloat = handlePointSize
    
    var moveGesture: some Gesture {
        DragGesture(minimumDistance: 0.1)
            .onChanged { value in
                var goalPoint = value.location
                
                
                if !canvasData.goalBezierPointQueue.isEmpty {
//                    if bezierPoint.isBinded {
//                        let symmetricPoint = getSymmetricPoint(pointA: goalPoint, pointB: bezierPoint.point)
//                        if distance(pointA: symmetricPoint, pointB: canvasData.goalBezierPointQueue.first!.cp1!) < distanceError {
//                            goalPoint = getSymmetricPoint(pointA: canvasData.goalBezierPointQueue.first!.cp1!, pointB: canvasData.goalBezierPointQueue.first!.point)
//                        }
//                        if distance(pointA: symmetricPoint, pointB: canvasData.goalBezierPointQueue.first!.cp2!) < distanceError {
//                            goalPoint = getSymmetricPoint(pointA: canvasData.goalBezierPointQueue.first!.cp2!, pointB: canvasData.goalBezierPointQueue.first!.point)
//                        }
//                    }
                    if distance(pointA: goalPoint, pointB: canvasData.goalBezierPointQueue.first!.cp1!) < distanceError {
                        goalPoint = canvasData.goalBezierPointQueue.first!.cp1!
                    }
                    if distance(pointA: goalPoint, pointB: canvasData.goalBezierPointQueue.first!.cp2!) < distanceError {
                        goalPoint = canvasData.goalBezierPointQueue.first!.cp2!
                    }
                }
                
                if status == 1 {
                    bezierPoint.cp1 = goalPoint
                    if bezierPoint.isBinded {
                        bezierPoint.cp2 = getSymmetricPoint(pointA: bezierPoint.cp1!, pointB: bezierPoint.point)
                    }
                } else {
                    bezierPoint.cp2 = goalPoint
                    if bezierPoint.isBinded {
                        bezierPoint.cp1 = getSymmetricPoint(pointA: bezierPoint.cp2!, pointB: bezierPoint.point)
                    }
                }
            }
            .onEnded { _ in
                if !canvasData.goalBezierPointQueue.isEmpty && bezierPoint == canvasData.goalBezierPointQueue.first! {
                    canvasData.goalBezierPointQueue.removeFirst()
                }
            }
    }
    
    var doubleTapGesture: some Gesture {
        TapGesture(count: 2)
            .onEnded { _ in
                bezierPoint.isBinded = false
            }
    }
    
    var body: some View {
        Circle()
            .foregroundColor(bezierPoint.isBinded ? insideColor : Color(red: 0.3, green: 0.3, blue: 0.3, opacity: 1))
            .frame(width: size, height: size)
            .overlay {
                Circle()
                    .stroke(color, lineWidth: 2)
            }
            .position(status == 1 ? bezierPoint.cp1! : bezierPoint.cp2!)
            .simultaneousGesture(moveGesture)
            .gesture(doubleTapGesture)
    }
    
    private func getSymmetricPoint(pointA: CGPoint, pointB: CGPoint) -> CGPoint {
        let deltaX = pointA.x - pointB.x
        let deltaY = pointA.y - pointB.y
        return CGPoint(x: pointB.x - deltaX, y: pointB.y - deltaY)
    }
}

struct Handle: View {
    @Binding var bezierPoint: BezierPoint
    var pointColor = Color.white
    var pointInsideColor = Color.black
    var controlPointColor = Color.white
    var controlPointInsideColor = Color.black
    
    var lineColor = Color.blue
    var lineWidth: CGFloat = 4.0
    
    var body: some View {
        Path { path in
            if bezierPoint.cp1 != nil {
                path.move(to: bezierPoint.point)
                path.addLine(to: bezierPoint.cp1!)
            }
            if bezierPoint.cp2 != nil {
                path.move(to: bezierPoint.point)
                path.addLine(to: bezierPoint.cp2!)
            }
        }
//        .stroke(lineColor, lineWidth: 4.0)
//        .contentShape(Rectangle())
        HandleControlPoint(bezierPoint: $bezierPoint, status: 1, color: controlPointColor, insideColor: controlPointInsideColor)
        HandleControlPoint(bezierPoint: $bezierPoint, status: 2, color: controlPointColor, insideColor: controlPointInsideColor)
        HandlePoint(bezierPoint: $bezierPoint, color: pointColor, insideColor: pointInsideColor)
    }
}

struct StaticHandlePoint: View {
    let size: CGFloat = handlePointSize
    var color = Color.white
    var insideColor = Color.black
    
    var body: some View {
        Circle()
            .foregroundColor(insideColor)
            .frame(width: size, height: size)
            .overlay {
                Circle()
                    .stroke(color, lineWidth: 2)
            }
    }
}

struct StaticHandle: View {
    let bezierPoint: BezierPoint
    
    var pointColor = Color.white
    var pointInsideColor = Color.black
    
    var controlPointColor = Color.white
    var controlPointInsideColor = Color.black
    
    var lineColor = Color.blue
    var lineWidth: CGFloat = 4.0
    
    var body: some View {
        Path { path in
            path.move(to: bezierPoint.point)
            if bezierPoint.cp1 != nil {
                path.addLine(to: bezierPoint.cp1!)
            }
            if bezierPoint.cp2 != nil {
                path.move(to: bezierPoint.point)
                path.addLine(to: bezierPoint.cp2!)
            }
        }
        .stroke(lineColor, lineWidth: lineWidth)
        .contentShape(Rectangle())
        if bezierPoint.cp1 != nil {
            StaticHandlePoint(color: controlPointColor, insideColor: controlPointInsideColor)
                .position(bezierPoint.cp1!)
        }
        if bezierPoint.cp2 != nil {
            StaticHandlePoint(color: controlPointColor, insideColor: controlPointInsideColor)
                .position(bezierPoint.cp2!)
        }
        StaticHandlePoint(color: pointColor, insideColor: pointInsideColor)
            .position(bezierPoint.point)
    }
}


