//
//  SpeedBoard.swift
//  Bezier
//
//  Created by Heyya on 2024/2/16.
//

import SwiftUI

struct SpeedBoard: View {
    @EnvironmentObject var canvasData: PageCanvasData
    
//    @State var startPoint = BezierPoint(point: CGPoint.zero, cp1: CGPoint.zero, cp2: CGPoint.zero)
//    @State var endPoint = BezierPoint(point: CGPoint.zero, cp1: CGPoint.zero, cp2: CGPoint.zero)
    @State var value: CGFloat = 0
    
    let timer = Timer.publish(every: 2, on: .main, in: .common).autoconnect()
    var animation: Animation {
        Animation.timingCurve(
            Double(canvasData.speedStartPoint.cp2!.x / canvasData.speedBoardGeometry.width),
            Double(1 - canvasData.speedStartPoint.cp2!.y / canvasData.speedBoardGeometry.height),
            Double(canvasData.speedEndPoint.cp1!.x / canvasData.speedBoardGeometry.width),
            Double(1 - canvasData.speedEndPoint.cp1!.y / canvasData.speedBoardGeometry.height),
            duration: 2)
    }
    
    let curveColor = Color.green
    let curveWidth: CGFloat = 4.0
    let handleColor = Color.blue
    let handleWidth: CGFloat = 2.0
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                // 速度曲线界面
                GeometryReader { geometry1 in
                    ScrollView {
                        GeometryReader { insideGeometry1 in
                            ZStack {
                                Path { path in
                                    path.move(to: canvasData.speedStartPoint.point)
                                    path.addCurve(to: canvasData.speedEndPoint.point, control1: canvasData.speedStartPoint.cp2!, control2: canvasData.speedEndPoint.cp1!)
                                }
                                .stroke(curveColor, lineWidth: curveWidth)
                                .contentShape(Rectangle())
                                Path { path in
                                    path.move(to: canvasData.speedStartPoint.point)
                                    path.addLine(to: canvasData.speedStartPoint.cp2!)
                                    path.move(to: canvasData.speedEndPoint.point)
                                    path.addLine(to: canvasData.speedEndPoint.cp1!)
                                }
                                .stroke(handleColor, lineWidth: handleWidth)
                                .contentShape(Rectangle())
                                StaticHandlePoint()
                                    .position(canvasData.speedStartPoint.point)
                                    .colorInvert()
                                StaticHandlePoint()
                                    .position(canvasData.speedEndPoint.point)
                                    .colorInvert()
                                HandleControlPoint(bezierPoint: $canvasData.speedStartPoint, status: 2)
                                HandleControlPoint(bezierPoint: $canvasData.speedEndPoint, status: 1)
                            }
                            .onAppear {
                                canvasData.speedBoardGeometry = insideGeometry1.size
                                canvasData.speedStartPoint.point = canvasData.speedStartPoint.point * canvasData.speedBoardGeometry
                                canvasData.speedStartPoint.cp2! = canvasData.speedStartPoint.cp2! * canvasData.speedBoardGeometry
                                canvasData.speedEndPoint.point = canvasData.speedEndPoint.point * canvasData.speedBoardGeometry
                                canvasData.speedEndPoint.cp1! = canvasData.speedEndPoint.cp1! * canvasData.speedBoardGeometry
                            }
                            .onDisappear {
                                canvasData.speedStartPoint = BezierPoint(point: CGPoint(x: 0, y: 1), cp2: CGPoint(x: 0.5, y: 0.7))
                                canvasData.speedEndPoint = BezierPoint(point: CGPoint(x: 1, y: 0), cp1: CGPoint(x: 0.5, y: 0.3))
                                canvasData.speedBoardGeometry = CGSize.zero
                            }
                        }
//                        .onAppear {
//                            print(geometry1.size.width)
//                        }
                        .padding(20)
                        .frame(width: geometry.size.width, height: geometry1.size.height)
                    }
                    .scrollDisabled(true)
                    .frame(width: geometry1.size.width, height: geometry1.size.height)
//                    .background(GlassCard())
                    Button {
                        canvasData.speedStartPoint.cp2 = CGPoint(x: geometry1.size.width / 2, y: geometry1.size.height * 0.7)
                        canvasData.speedEndPoint.cp1 = CGPoint(x: geometry1.size.width / 2, y: geometry1.size.height * 0.3)
                    } label: {
                        Text("Reset")
                            .font(.body.bold().monospaced())
                            .foregroundColor(.white)
                            .padding(10)
                            .background {
                                GlassCard()
                            }
                    }
                    .padding(20)
                }
                .background {
                    GlassCard()
                }
                
                // 动画预览界面
                GeometryReader { geometry2 in
                    Circle()
                        .position(x: 0, y: 0)
                        .offset(x: self.value * geometry2.size.width, y: 0)
                        .frame(height: 12)
                        .onReceive(timer) { _ in
                            self.value = 0
                            withAnimation(animation) {
                                    value = 1
                                }
                        }
                }
                .padding(20)
                .frame(height: 40)
                .background {
                    GlassCard()
                }
            }
        }
    }
}

struct SpeedBoard_Previews: PreviewProvider {
    static var previews: some View {
        SpeedBoard()
            .frame(width: 1000)
    }
}
