//
//  PageDataCanvasChapter1Section1.swift
//  Bezier
//
//  Created by Heyya on 2024/2/20.
//

import SwiftUI

struct PageDataCanvasChapter1Section1: View {
    @ObservedObject var pageData = PageManager.shared.pageData
    
    @State var initPoint1 = BezierPoint(point: CGPoint.zero)
    @State var initPoint2 = BezierPoint(point: CGPoint.zero)
    @State var initPoint3 = BezierPoint(point: CGPoint.zero)
    
    
    @State var movePoint1 = BezierPoint(point: CGPoint.zero)
    @State var movePoint2 = BezierPoint(point: CGPoint.zero)
    @State var movePoint3 = BezierPoint(point: CGPoint.zero)
    
    @State var value: CGFloat = 0
    
    let curveColor = Color.green
    let curveWidth: CGFloat = 4.0
    let baseLineColor = Color.white
    let baseLineWidth: CGFloat = 4.0
    let lineColor = Color.blue
    let lineWidth: CGFloat = 4.0
    
    let footerGap: CGPoint = CGPoint(x: 20, y: 20)
    
    let timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
    @State var isIncreasing = false
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Path { path in
                    path.move(to: initPoint1.point)
                    path.addLine(to: initPoint2.point)
                    path.move(to: initPoint2.point)
                    path.addLine(to: initPoint3.point)
                }
                .stroke(baseLineColor, lineWidth: baseLineWidth)
                .contentShape(Rectangle())
                
//                Path { path in
//                    path.move(to: initPoint1.point)
//                    path.addLine(to: movePoint1.point)
//                    path.move(to: initPoint2.point)
//                    path.addLine(to: movePoint2.point)
//                }
//                .stroke(lineColor, lineWidth: lineWidth)
//                .contentShape(Rectangle())
                
                if pageData.canvasData.showQuadraticCurve {
                    Path { path in
                        path.move(to: initPoint1.point)
                        path.addQuadCurve(to: initPoint3.point, control: initPoint2.point)
                    }
                    .stroke(curveColor, lineWidth: curveWidth)
                    .contentShape(Rectangle())
                }
                
                if pageData.canvasData.showMovePoint3 {
                    Path { path in
                        path.move(to: movePoint1.point)
                        path.addLine(to: movePoint2.point)
                    }
                    .stroke(lineColor, lineWidth: lineWidth)
                    .contentShape(Rectangle())
                    StaticHandlePoint(insideColor: curveColor)
                        .position(movePoint3.point)
                }
                
                StaticHandlePoint(insideColor: .gray)
                    .position(movePoint1.point)
                    .onReceive(timer) { _ in
                        if value >= 1 {
                            isIncreasing = false
                        } else if value <= 0 {
                            isIncreasing = true
                        }
                        value += 0.005 * (isIncreasing ? 1 : -1)
                        movePoint1.point = initPoint1.point + (initPoint2.point - initPoint1.point) * value
                        movePoint2.point = initPoint2.point + (initPoint3.point - initPoint2.point) * value
                        movePoint3.point = movePoint1.point + (movePoint2.point - movePoint1.point) * value
                    }
                StaticHandlePoint(insideColor: .gray)
                    .position(movePoint2.point)
                
//                Text("P")
//                    .position(movePoint1.point + footerGap)
//                    .font(.body.monospaced())
                
                
                StaticHandlePoint()
                    .position(initPoint1.point)
                Text("P_0")
                    .position(initPoint1.point - footerGap)
                    .font(.body.monospaced())
                StaticHandlePoint()
                    .position(initPoint2.point)
                StaticHandlePoint()
                    .position(initPoint3.point)
                Text("P_1")
                    .position(initPoint3.point - footerGap)
                    .font(.body.monospaced())
                Text("t: \(String(format: "%.2f", value))")
                    .position(movePoint1.point - footerGap)
                    .font(.body.monospaced())
                Text("t: \(String(format: "%.2f", value))")
                    .position(movePoint2.point - footerGap)
                    .font(.body.monospaced())
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
            .onAppear {
                initPoint1.point = CGPoint(x: geometry.size.width * 0.3, y: geometry.size.height * 0.6)
                initPoint2.point = CGPoint(x: geometry.size.width * 0.5, y: geometry.size.height * 0.4)
                movePoint1.point = initPoint1.point
                initPoint3.point = CGPoint(x: geometry.size.width * 0.7, y: geometry.size.height * 0.6)
                movePoint2.point = initPoint2.point
            }
        }
        .padding(20)
        .background(GlassCard())
    }
}

struct PageDataCanvasChapter1Section1_Previews: PreviewProvider {
    static var previews: some View {
        PageDataCanvasChapter1Section1()
    }
}
