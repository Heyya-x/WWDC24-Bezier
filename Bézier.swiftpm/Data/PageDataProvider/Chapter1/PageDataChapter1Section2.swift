//
//  PageDataChapter1Section2.swift
//  Bezier
//
//  Created by Heyya on 2024/2/20.
//

import Foundation
import SwiftUI

class PageDataChapter1Section2: PageDataProvider {
    func modifyDocView(pageData: PageData) {
        pageData.docView = AnyView(
            List {
                Section {
                    Text("📚 Bézier Curve")
                        .font(.title2.monospaced())
                        .listRowBackground(Color.gray.opacity(0.3))
                    Text("🔱 Chapter 1 - Draw a Bézier curve")
                        .font(.subheadline.monospaced())
                        .listRowBackground(Color.gray.opacity(0.3))
                    Text("⚜️ Section 2 - Cubic Bézier Curve")
                        .font(.subheadline.monospaced())
                        .listRowBackground(Color.gray.opacity(0.3))
                    
                } header: {
                    VStack(alignment: .leading) {
                        Color.clear.frame(height: 20)
                        Text("TITLE")
                    }
                }
                
                Section("Learn") {
                    Text("🤔 Given the four initial points provided, we have already applied the operations from section 1 between adjacent points. ")
                        .font(.footnote.monospaced())
                        .listRowBackground(Color.gray.opacity(0.3))
                    Text("What will happen if we perform the operations of section 2 again?")
                        .font(.footnote.monospaced())
                        .listRowBackground(Color.gray.opacity(0.3))
                    Button("Show Answer") {
                        pageData.canvasData.showMovePoint4AndPoint5 = true
                    }
                    .font(.footnote.bold().monospaced())
                    .listRowBackground(Color.gray.opacity(0.3))
                }
                
                Section("Think") {
                    Text("1. Clearly, we obtain two new points. You've probably thought of adding a new point between the blue points, haven't you? Let's see the result!")
                        .font(.footnote.monospaced())
                        .listRowBackground(Color.gray.opacity(0.3))
                    Button("Show Answer") {
                        pageData.canvasData.showMovePoint6 = true
                    }
                    .font(.footnote.bold().monospaced())
                    .listRowBackground(Color.gray.opacity(0.3))
                    
                    Text("2. What is the curve obtained by the movement of the green point?")
                        .font(.footnote.monospaced())
                        .listRowBackground(Color.gray.opacity(0.3))
                    Button("Show Answer") {
                        pageData.canvasData.showCubicCurve = true
                    }
                    .font(.footnote.bold().monospaced())
                    .listRowBackground(Color.gray.opacity(0.3))
                    
                    Text("3. Let's hide some other points and lines. We call this curve the \"Cubic Bézier Curve.\"")
                        .font(.footnote.monospaced())
                        .listRowBackground(Color.gray.opacity(0.3))
                    Button("Hide/Show Other") {
                        pageData.canvasData.showOtherPoints = !pageData.canvasData.showOtherPoints
                    }
                    .font(.footnote.bold().monospaced())
                    .listRowBackground(Color.gray.opacity(0.3))
                    
                    Text("4. Let's explore curves of other shapes!")
                        .font(.footnote.monospaced())
                        .listRowBackground(Color.gray.opacity(0.3))
                    Button("Show More") {                        
                        pageData.canvasData.showMore = true
                    }
                    .font(.footnote.bold().monospaced())
                    .listRowBackground(Color.gray.opacity(0.3))
                    
                    
                }
                
                Section("Custom") {
                    Text("Let's try to make curve customly")
                        .font(.footnote.monospaced())
                        .listRowBackground(Color.gray.opacity(0.3))
                    Text("👆 | Draw the point to change the shape of curve.")
                        .font(.footnote.monospaced())
                        .listRowBackground(Color.gray.opacity(0.3))
                }
                
                Section {
                    Button {
                        pageData.switchTo(index: 11)
                    } label: {
                        Label("Previous Section", systemImage: "arrow.left")
                            .font(.body.monospaced())
                            .listRowBackground(Color.gray.opacity(0.3))
                    }
                    .listRowBackground(Color.gray.opacity(0.3))
                    
                    Button {
                        pageData.switchTo(index: 20)
                    } label: {
                        Label("Next Chapter", systemImage: "arrow.right")
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
        pageData.canvasView = AnyView(PageDataCanvasChapter1Section2())
        pageData.canvasData.canvasTitle = "Cubic Bézier Curve"
    }
}

