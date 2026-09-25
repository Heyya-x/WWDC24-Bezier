//
//  PageDataChapterZero+Section0.swift
//  Bezier
//
//  Created by Heyya on 2024/2/19.
//

import SwiftUI

struct PageDataCanvasChapter1Section0: View {
    @State var initPoint1 = BezierPoint(point: CGPoint.zero, cp1: nil, cp2: nil)
    @State var initPoint2 = BezierPoint(point: CGPoint.zero, cp1: nil, cp2: nil)
    @State var movePoint = BezierPoint(point: CGPoint.zero, cp1: nil, cp2: nil)
    
    @State var value: CGFloat = 0
    
    let curveColor = Color.green
    let curveWidth: CGFloat = 4.0
    let baseLineColor = Color.gray
    let baseLineWidth: CGFloat = 4.0
    
    let footerGapLeadingTop: CGPoint = CGPoint(x: -20, y: -20)
    let footerGapTrailingTop: CGPoint = CGPoint(x: 20, y: -20)
    let footerGapTrailingBottom: CGPoint = CGPoint(x: 20, y: 20)
    
    let timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
    @State var isIncreasing = false
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Path { path in
                    path.move(to: initPoint1.point)
                    path.addLine(to: initPoint2.point)
                    path.addLine(to: movePoint.point)
                }
                .stroke(baseLineColor, lineWidth: baseLineWidth)
                .contentShape(Rectangle())
                
                Path { path in
                    path.move(to: initPoint1.point)
                    path.addLine(to: movePoint.point)
                }
                .stroke(curveColor, lineWidth: curveWidth)
                .contentShape(Rectangle())
                
                StaticHandlePoint(insideColor: .gray)
                    .position(movePoint.point)
                    .onReceive(timer) { _ in
                        if value >= 1 {
                            isIncreasing = false
                        } else if value <= 0 {
                            isIncreasing = true
                        }
                        value += 0.005 * (isIncreasing ? 1 : -1)
                        movePoint.point = initPoint1.point + (initPoint2.point - initPoint1.point) * value
                    }
                
                Text("P")
                    .position(movePoint.point + footerGapTrailingBottom)
                    .font(.body.monospaced())
                
                StaticHandlePoint()
                    .position(initPoint1.point)
                Text("P_0")
                    .position(initPoint1.point + footerGapLeadingTop)
                    .font(.body.monospaced())
                StaticHandlePoint()
                    .position(initPoint2.point)
                Text("P_1")
                    .position(initPoint2.point + footerGapTrailingTop)
                    .font(.body.monospaced())
                Text("t: \(String(format: "%.2f", value))")
                    .position(movePoint.point + footerGapLeadingTop * 2)
                    .font(.body.monospaced())
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
            .onAppear {
                initPoint1.point = CGPoint(x: geometry.size.width * 0.3, y: geometry.size.height * 0.6)
                movePoint.point = initPoint1.point
                initPoint2.point = CGPoint(x: geometry.size.width * 0.6, y: geometry.size.height * 0.3)
            }
        }
        .padding(20)
        .background(GlassCard())
    }
}

struct PageDataCanvasChapter1Section0_Previews: PreviewProvider {
    static var previews: some View {
        PageDataCanvasChapter1Section0()
    }
}
