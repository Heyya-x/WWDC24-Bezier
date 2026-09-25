//
//  PageDataCanvasChapter1Section2.swift
//  Bezier
//
//  Created by Heyya on 2024/2/20.
//

import SwiftUI

struct PageDataCanvasChapter1Section2: View {
    @ObservedObject var pageData = PageManager.shared.pageData
    
    @State var initPoint1 = BezierPoint(point: CGPoint.zero)
    @State var initPoint2 = BezierPoint(point: CGPoint.zero)
    @State var initPoint3 = BezierPoint(point: CGPoint.zero)
    @State var initPoint4 = BezierPoint(point: CGPoint.zero)
    
    @State var movePoint1 = BezierPoint(point: CGPoint.zero)
    @State var movePoint2 = BezierPoint(point: CGPoint.zero)
    @State var movePoint3 = BezierPoint(point: CGPoint.zero)
    @State var movePoint4 = BezierPoint(point: CGPoint.zero)
    @State var movePoint5 = BezierPoint(point: CGPoint.zero)
    @State var movePoint6 = BezierPoint(point: CGPoint.zero)
    
    @State var value: CGFloat = 0
    
    let curveColor = Color.green
    let curveWidth: CGFloat = 4.0
    let baseLineColor = Color.white
    let baseLineWidth: CGFloat = 2.0
    let lineColor = Color.blue
    let lineWidth: CGFloat = 4.0
    
    let footerGap: CGPoint = CGPoint(x: 20, y: 20)
    
    let timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
    @State var isIncreasing = false
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                ZStack {
                    Path { path in
                        path.move(to: initPoint1.point)
                        path.addLine(to: initPoint2.point)
                        if pageData.canvasData.showOtherPoints {
                            path.move(to: initPoint2.point)
                            path.addLine(to: initPoint3.point)
                        }
                        path.move(to: initPoint3.point)
                        path.addLine(to: initPoint4.point)
                    }
                    .stroke(baseLineColor, lineWidth: baseLineWidth)
                    .contentShape(Rectangle())
                    .onReceive(timer) { _ in
                        if value >= 1 {
                            isIncreasing = false
                        } else if value <= 0 {
                            isIncreasing = true
                        }
                        value += 0.005 * (isIncreasing ? 1 : -1)
                        movePoint1.point = initPoint1.point + (initPoint2.point - initPoint1.point) * value
                        movePoint2.point = initPoint2.point + (initPoint3.point - initPoint2.point) * value
                        movePoint3.point = initPoint3.point + (initPoint4.point - initPoint3.point) * value
                        
                        movePoint4.point = movePoint1.point + (movePoint2.point - movePoint1.point) * value
                        movePoint5.point = movePoint2.point + (movePoint3.point - movePoint2.point) * value
                        movePoint6.point = movePoint4.point + (movePoint5.point - movePoint4.point) * value
                        
                        if pageData.canvasData.showMore {
                            pageData.canvasData.showMore = false
                            withAnimation(.easeInOut) {
                                initPoint1.point = CGPoint(x: geometry.size.width * 0.3, y: geometry.size.height * 0.6)
                                initPoint2.point = CGPoint(x: geometry.size.width * 0.8, y: geometry.size.height * 0.4)
                                initPoint3.point = CGPoint(x: geometry.size.width * 0.2, y: geometry.size.height * 0.4)
                                initPoint4.point = CGPoint(x: geometry.size.width * 0.7, y: geometry.size.height * 0.6)
                            }
                        }
                    }
                    
                    if pageData.canvasData.showCubicCurve {
                        Path { path in
                            path.move(to: initPoint1.point)
                            path.addCurve(to: initPoint4.point, control1: initPoint2.point, control2: initPoint3.point)
                        }
                        .stroke(curveColor, lineWidth: curveWidth)
                        .contentShape(Rectangle())
                    }
                    
                    if pageData.canvasData.showMovePoint4AndPoint5 && pageData.canvasData.showOtherPoints {
                        Path { path in
                            path.move(to: movePoint1.point)
                            path.addLine(to: movePoint2.point)
                            path.move(to: movePoint2.point)
                            path.addLine(to: movePoint3.point)
                        }
                        .stroke(.gray, lineWidth: lineWidth)
                        .contentShape(Rectangle())
                        StaticHandlePoint(insideColor: .blue)
                            .position(movePoint4.point)
                        StaticHandlePoint(insideColor: .blue)
                            .position(movePoint5.point)
                    }
                    if pageData.canvasData.showMovePoint6  && pageData.canvasData.showOtherPoints {
                        Path { path in
                            path.move(to: movePoint4.point)
                            path.addLine(to: movePoint5.point)
                        }
                        .stroke(lineColor, lineWidth: lineWidth)
                        .contentShape(Rectangle())
                        StaticHandlePoint(insideColor: .green)
                            .position(movePoint6.point)
                    }
                    
                    if pageData.canvasData.showOtherPoints {
                        StaticHandlePoint(insideColor: .gray)
                            .position(movePoint1.point)
                        StaticHandlePoint(insideColor: .gray)
                            .position(movePoint2.point)
                        StaticHandlePoint(insideColor: .gray)
                            .position(movePoint3.point)
                    }
                    
                    
                    HandlePoint(bezierPoint: $initPoint1)
                    HandlePoint(bezierPoint: $initPoint2)
                    HandlePoint(bezierPoint: $initPoint3)
                    HandlePoint(bezierPoint: $initPoint4)
                    
                    Text("P_0")
                        .position(initPoint1.point - footerGap)
                    Text("P_1")
                        .position(initPoint2.point - footerGap)
                    Text("P_2")
                        .position(initPoint3.point - footerGap)
                    Text("P_3")
                        .position(initPoint4.point - footerGap)
                    
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
                .onAppear {
                    initPoint1.point = CGPoint(x: geometry.size.width * 0.3, y: geometry.size.height * 0.6)
                    initPoint2.point = CGPoint(x: geometry.size.width * 0.35, y: geometry.size.height * 0.4)
                    initPoint3.point = CGPoint(x: geometry.size.width * 0.65, y: geometry.size.height * 0.4)
                    initPoint4.point = CGPoint(x: geometry.size.width * 0.7, y: geometry.size.height * 0.6)
                    movePoint1.point = initPoint1.point
                    movePoint2.point = initPoint2.point
                    movePoint3.point = initPoint3.point
                }
            }
            .scrollDisabled(true)
            .frame(height: geometry.size.height)
            .background(GlassCard())
        }
    }
}

struct PageDataCanvasChapter1Section2_Previews: PreviewProvider {
    static var previews: some View {
        PageDataCanvasChapter1Section2()
    }
}
