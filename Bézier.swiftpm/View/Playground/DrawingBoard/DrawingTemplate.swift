//
//  DrawingTemplate.swift
//  Bezier
//
//  Created by Heyya on 2024/2/22.
//

import SwiftUI

struct DrawingTemplate: View {
//    @EnvironmentObject var pageData: PageData
    @EnvironmentObject var canvasData: PageCanvasData
    @State private var curve: [[BezierPoint]] = [[BezierPoint]]()
    @Binding var showHandle: Bool
    let curveColor = Color.gray
    let curveWidth: CGFloat = 4.0
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ForEach(curve.indices, id: \.self) { number in
                    ForEach(Array(curve[number].enumerated()), id: \.offset) { index, bezierPoint in
                            let preIndex = (index - 1 + curve[number].count) % curve[number].count
                            let curveStart = curve[number][preIndex].point
                            let curveEnd = curve[number][index].point
                            let cp1 = curve[number][preIndex].cp2
                            let cp2 = curve[number][index].cp1
                            Path { path in
                                path.move(to: curveStart)
                                path.addCurve(to: curveEnd, control1: cp1!, control2: cp2!)
                            }
                            .stroke(curveColor, lineWidth: curveWidth)
                            .contentShape(Rectangle())
                    }
                }
                if showHandle {
                    ForEach(curve.indices, id: \.self) { number in
                        ForEach(Array(curve[number].enumerated()), id: \.offset) { index, bezierPoint in
                            //                        StaticHandle(bezierPoint: bezierPoint)
                            if !canvasData.goalBezierPointQueue.isEmpty && bezierPoint == canvasData.goalBezierPointQueue.first! {
                                StaticHandle(bezierPoint: bezierPoint, pointInsideColor: .green.opacity(0.8), controlPointInsideColor: .green.opacity(0.4), lineColor: .gray)
                            } else {
                                StaticHandle(bezierPoint: bezierPoint, pointInsideColor: .gray, controlPointInsideColor: .gray, lineColor: .gray)
                            }
                            
                        }
                    }
                }
            }
            .onAppear {
                var leaf = [BezierPoint]()
                var apple = [BezierPoint]()
                let deltaX = CGPoint(x: (geometry.size.width - geometry.size.height) / 2, y: 0)
                for point in canvasData.leaf {
                    let newPoint = BezierPoint(point: point[0] * geometry.size.height + deltaX,
                                               cp1: point[1] * geometry.size.height + deltaX,
                                               cp2: point[2] * geometry.size.height + deltaX)
                    leaf.append(newPoint)
                    canvasData.goalBezierPointQueue.append(newPoint)
                }
                for point in canvasData.apple {
                    let newPoint = BezierPoint(point: point[0] * geometry.size.height + deltaX,
                                               cp1: point[1] * geometry.size.height + deltaX,
                                               cp2: point[2] * geometry.size.height + deltaX)
                    apple.append(newPoint)
                    canvasData.goalBezierPointQueue.append(newPoint)
                }
                curve = [leaf, apple]
                canvasData.templateCurve = curve
            }
            .onDisappear {
                canvasData.templateCurve = [[BezierPoint]]()
                canvasData.goalBezierPointQueue = [BezierPoint]()
            }
        }
    }
}

struct DrawingTemplate_Previews: PreviewProvider {
    @State static var showHandle = true
    static var previews: some View {
        DrawingTemplate(showHandle: $showHandle)
            .environmentObject(PageManager.shared.pageData.canvasData)
    }
}
