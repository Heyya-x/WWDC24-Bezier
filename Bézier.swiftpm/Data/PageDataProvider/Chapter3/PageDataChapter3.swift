//
//  PageDataChapterThree.swift
//  Bezier
//
//  Created by Heyya on 2024/2/18.
//

import Foundation
import SwiftUI

class PageDataChapter3: PageDataProvider {
    func modifyDocView(pageData: PageData) {
        pageData.docView = AnyView(
            List {
                Section {
                    Text("📚 Bézier Curve")
                        .font(.title2.monospaced())
                        .listRowBackground(Color.gray.opacity(0.3))
                    Text("🔱 Chapter 3 - Control Speed")
                        .font(.subheadline.monospaced())
                        .listRowBackground(Color.gray.opacity(0.3))
                } header: {
                    VStack(alignment: .leading) {
                        Color.clear.frame(height: 20)
                        Text("TITLE")
                    }
                }
                
                Section("Speed Control") {
                    Text("This section provides another use for Bezier curves - controlling speed!")
                        .font(.footnote.monospaced())
                        .listRowBackground(Color.gray.opacity(0.3))
                    Text("Try dragging the control points to adjust the motion of the bottom ball!")
                        .font(.footnote.monospaced())
                        .listRowBackground(Color.gray.opacity(0.3))
                }
                
                Section("Different Type") {
                    Button {
                        withAnimation {
                            pageData.canvasData.speedStartPoint.cp2 = CGPoint(x: 0.5, y: 1) * pageData.canvasData.speedBoardGeometry
                            pageData.canvasData.speedEndPoint.cp1 = CGPoint(x: 1, y: 0) * pageData.canvasData.speedBoardGeometry
                        }
                    } label: {
                        Text("EaseIn")
                            .font(.footnote.bold().monospaced())
                            .listRowBackground(Color.gray.opacity(0.3))
                    }
                    .font(.footnote.bold().monospaced())
                    .listRowBackground(Color.gray.opacity(0.3))
                    Button {
                        withAnimation {
                            pageData.canvasData.speedStartPoint.cp2 = CGPoint(x: 0, y: 1) * pageData.canvasData.speedBoardGeometry
                            pageData.canvasData.speedEndPoint.cp1 = CGPoint(x: 0.5, y: 0) * pageData.canvasData.speedBoardGeometry
                        }
                    } label: {
                        Text("EaseOut")
                            .font(.footnote.bold().monospaced())
                            .listRowBackground(Color.gray.opacity(0.3))
                    }
                    .font(.footnote.bold().monospaced())
                    .listRowBackground(Color.gray.opacity(0.3))
                    Button {
                        withAnimation {
                            pageData.canvasData.speedStartPoint.cp2 = CGPoint(x: 0.5, y: 1) * pageData.canvasData.speedBoardGeometry
                            pageData.canvasData.speedEndPoint.cp1 = CGPoint(x: 0.5, y: 0) * pageData.canvasData.speedBoardGeometry
                        }
                    } label: {
                        Text("EaseInOut")
                            .font(.footnote.bold().monospaced())
                            .listRowBackground(Color.gray.opacity(0.3))
                    }
                    .listRowBackground(Color.gray.opacity(0.3))
                }
                
                Section {
                    Button {
                        pageData.switchTo(index: 21)
                    } label: {
                        Label("Previous Section", systemImage: "arrow.left")
                            .font(.body.monospaced())
                            .listRowBackground(Color.gray.opacity(0.3))
                    }
                    .listRowBackground(Color.gray.opacity(0.3))
                }
                
                Section("More") {
                    Button {
                        pageData.switchTo(index: -1)
                    } label: {
                        Text("Final")
                            .font(.body.bold().monospaced())
                            .listRowBackground(Color.gray.opacity(0.3))
                    }
                    .listRowBackground(Color.gray.opacity(0.3))
                }
                
            }
            .scrollContentBackground(.hidden)
            .mask(RoundedRectangle(cornerRadius: 16))
            .background {
                GlassCard()
            }
        )
    }
    
    func modifyCanvasView(pageData: PageData) {
        pageData.canvasView = AnyView(SpeedBoard())
        pageData.canvasData.canvasTitle = "Speed"
    }
}

