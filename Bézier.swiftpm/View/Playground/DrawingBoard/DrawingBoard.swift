//
//  Curve.swift
//  Bezier
//
//  Created by Heyya on 2024/2/22.
//

import SwiftUI

struct DrawingBoard: View {
    @EnvironmentObject var pageData: PageData
    @EnvironmentObject var canvasData: PageCanvasData
    
    @State var dragStart: CGPoint? = nil
    @State var dragEnd: CGPoint? = nil
    private var dragSymmetric: CGPoint? {
        if dragEnd != nil {
            return getSymmetricPoint(pointA: dragEnd!, pointB: dragStart!)
        } else {
            return nil
        }
    }
    
    @State var isClosed = false
    @State var bezierCurve = [[BezierPoint]]()
    @State var isDrawing = false
    @State var showCurrentCurve = false
    @State var showControl = false
    @State var showHandle = true
//    @State var showAnswer = false
    
    var showTemplate: Bool = false
    
    let curveColor = Color.green
    let curveWidth: CGFloat = 4.0
    let handleColor = Color.blue
    let handleWidth: CGFloat = 2.0
    
    let distanceError: CGFloat = 30
    
    var DrawingGesture: some Gesture {
        DragGesture(minimumDistance: 0)
            .onChanged { value in
                dragStart = value.startLocation
                dragEnd = value.location
                showCurrentCurve = !isClosed
                showControl = true
                showHandle = true
                
                if !canvasData.goalBezierPointQueue.isEmpty {
                    if distance(pointA: dragStart!, pointB: canvasData.goalBezierPointQueue.first!.point) < distanceError {
                        dragStart = canvasData.goalBezierPointQueue.first!.point
                    }
                    if distance(pointA: dragEnd!, pointB: canvasData.goalBezierPointQueue.first!.cp2!) < distanceError || distance(pointA: dragSymmetric!, pointB: canvasData.goalBezierPointQueue.first!.cp1!) < distanceError {
                        dragEnd = canvasData.goalBezierPointQueue.first!.cp2!
                    }
                }
                
                if bezierCurve.count > 0 && bezierCurve.last!.count > 1 && distance(pointA: dragStart!, pointB: bezierCurve.last!.first!.point) < distanceError && !isClosed {
                    isClosed = true
                    dragStart = bezierCurve.last!.first!.point
                    dragEnd = bezierCurve.last!.first!.cp2!
                }
            }
            .onEnded { value in
                showCurrentCurve = false
                showControl = false
                
                let newBezierPoint = BezierPoint(point: dragStart!, cp1: dragSymmetric, cp2: dragEnd)
                if isDrawing {
                    if !isClosed {
                        let index = bezierCurve.count - 1
                        bezierCurve[index].append(newBezierPoint)
                    }
                } else {
                    // 添加第一个点后开始绘画
                    bezierCurve.append([newBezierPoint])
                    isDrawing = true
                    isClosed = false
                }
                
                if isClosed {
                    isDrawing = false
                    dragStart = nil
                    dragEnd = nil
                }
                
                if !canvasData.goalBezierPointQueue.isEmpty && bezierCurve.last!.last! == canvasData.goalBezierPointQueue.first! {
                    canvasData.goalBezierPointQueue.removeFirst()
                }
                
            }
    }
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                if canvasData.showResult {
                    ZStack {}
                        .onAppear {
                            bezierCurve = canvasData.templateCurve
                            isClosed = true
                        }
                        .onDisappear {
                            bezierCurve = [[BezierPoint]]()
                            isClosed = false
                            isDrawing = false
                        }
                }
                // 绘制曲线
                ZStack {
                    if showTemplate {
                        DrawingTemplate(showHandle: $showHandle)
                            .onAppear {
                                bezierCurve = [[BezierPoint]]()
                                isClosed = false
                                isDrawing = false
                            }
                            .environmentObject(pageData)
                    }
                    
                    // 绘制已有曲线
                    ForEach(bezierCurve.indices, id: \.self) { number in
                        ForEach(Array(bezierCurve[number].enumerated()), id: \.offset) { index, bezierPoint in
                            if number < bezierCurve.count - 1 || isClosed || index != 0 {
                                let preIndex = (index - 1 + bezierCurve[number].count) % bezierCurve[number].count
                                let curveStart = bezierCurve[number][preIndex].point
                                let curveEnd = bezierCurve[number][index].point
                                let cp1 = bezierCurve[number][preIndex].cp2
                                let cp2 = bezierCurve[number][index].cp1
                                Path { path in
                                    path.move(to: curveStart)
                                    path.addCurve(to: curveEnd, control1: cp1!, control2: cp2!)
                                }
                                .stroke(curveColor, lineWidth: curveWidth)
                                .contentShape(Rectangle())
                            }
                        }
                    }
                    
                    // 绘制当前曲线
                    Path { path in
                        if showCurrentCurve && !bezierCurve.isEmpty && !bezierCurve.last!.isEmpty {
                            path.move(to: bezierCurve.last!.last!.point)
                            path.addCurve(to: dragStart!, control1: bezierCurve.last!.last!.cp2!, control2: dragSymmetric!)
                        }
                    }
                    .stroke(curveColor, lineWidth: curveWidth)
                    .contentShape(Rectangle())
                    // 绘制当前句柄
                    Path { path in
                        if showCurrentCurve && dragStart != nil {
                            path.move(to: dragStart!)
                            path.addLine(to: dragEnd!)
                            path.move(to: dragStart!)
                            path.addLine(to: dragSymmetric!)
                        }
                    }
                    .stroke(handleColor, lineWidth: handleWidth)
                    .contentShape(Rectangle())
                    if showControl {
                        StaticHandle(bezierPoint: BezierPoint(point: dragStart!, cp1: dragSymmetric, cp2: dragEnd), lineWidth: handleWidth)
                    }
                    
                    // 绘制已有曲线句柄
                    if showHandle {
                        ForEach(bezierCurve.indices, id: \.self) { number in
                            ForEach(bezierCurve[number]) { bezierPoint in
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
                                .stroke(handleColor, lineWidth: handleWidth)
                                .contentShape(Rectangle())
                            }
                        }
                        ForEach(bezierCurve.indices, id: \.self) { number in
                            ForEach($bezierCurve[number]) { bezierPoint in
                                Handle(bezierPoint: bezierPoint)
                            }
                        }
                    }
                }
                .gesture(DrawingGesture)
                .frame(height: geometry.size.height)
                
            }
            .scrollDisabled(true)
            .frame(height: geometry.size.height)
            .background(GlassCard())
            .clipShape(RoundedRectangle(cornerRadius: 16))
//            .navigationBarHidden(true)
            
            // Reset and Undo Button
            OperationButtons(bezierCurve: $bezierCurve, dragStart: $dragStart, dragEnd: $dragEnd, isDrawing: $isDrawing, isClosed: $isClosed, showHandle: $showHandle)
            .padding(20)
        }
        .environmentObject(canvasData)
    }
}

struct OperationButtons: View {
    @EnvironmentObject var canvasData: PageCanvasData
    
    @Binding var bezierCurve: [[BezierPoint]]
    @Binding var dragStart: CGPoint?
    @Binding var dragEnd: CGPoint?
    @Binding var isDrawing: Bool
    @Binding var isClosed: Bool
    @Binding var showHandle: Bool
    
    var body: some View {
        ZStack {
            HStack() {
                HStack {
                    Button {
                        bezierCurve = [[BezierPoint]]()
                        isDrawing = false
                        isClosed = false
                        dragStart = nil
                        dragEnd = nil
                    } label: {
                        Text("Reset")
                            .font(.body.bold().monospaced())
                            .foregroundColor(.white)
                            .padding(10)
                            .background {
                                GlassCard()
                            }
                    }
                    Button {
                        if !bezierCurve.isEmpty {
                            let count = bezierCurve.count
                            if bezierCurve[count - 1].count > 1 {
                                if isClosed {
                                    isClosed = false
                                    isDrawing = true
                                } else {
                                    bezierCurve[count - 1].removeLast()
                                    isClosed = false
                                    isDrawing = true
                                }
                            } else {
                                bezierCurve.removeLast()
                                isClosed = true
                                isDrawing = false
                            }
                        }
                    } label: {
                        Text("Pop Back")
                            .font(.body.bold().monospaced())
                            .foregroundColor(.white)
                            .padding(10)
                            .background {
                                GlassCard()
                            }
                    }
                }
                Spacer()
                
                Button {
                    showHandle.toggle()
                } label: {
                    Text(showHandle ? "Hide Ctrl":"Show Ctrl")
                        .font(.body.bold().monospaced())
                        .foregroundColor(.white)
                        .padding(10)
                        .background {
                            GlassCard()
                        }
                }
            }
        }
    }
}

struct DrawingBoard_Previews: PreviewProvider {
    static var previews: some View {
        DrawingBoard()
    }
}
