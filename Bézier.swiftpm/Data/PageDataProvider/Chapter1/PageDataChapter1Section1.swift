//
//  PageDataChapter1Section1.swift
//  Bezier
//
//  Created by Heyya on 2024/2/20.
//

import Foundation
import SwiftUI

class PageDataChapter1Section1: PageDataProvider {
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
                    Text("⚜️ Section 1 - Quadratic Bézier Curve")
                        .font(.subheadline.monospaced())
                        .listRowBackground(Color.gray.opacity(0.3))
                } header: {
                    VStack(alignment: .leading) {
                        Color.clear.frame(height: 20)
                        Text("TITLE")
                    }
                }
                
                Section("Learn") {
                    // 与前面一节类似，我们在两个点之间插入一个新的点，标为蓝色的点
                    Text("🤔 Now, with the initial points increased from 2 to 3, similar to the previous section, let's add new movable points, Q0 and Q1, between the connected initial points. These two points' positions will also be represented by t.")
                        .font(.footnote.monospaced())
                        .listRowBackground(Color.gray.opacity(0.3))
                }
                
                Section("Think") {
                    Text("1. If we draw a line between Q0 and Q1 and perform the same operations as in section 1, what will happen?")
                        .font(.footnote.monospaced())
                        .listRowBackground(Color.gray.opacity(0.3))
                    Button("Show Answer") {
                        pageData.canvasData.showMovePoint3 = true
                    }
                    .font(.footnote.bold().monospaced())
                    .listRowBackground(Color.gray.opacity(0.3))
                    
                    Text("2. What is the curve obtained by the movement of the green point?")
                        .font(.footnote.monospaced())
                        .listRowBackground(Color.gray.opacity(0.3))
                    Button("Show Answer") {
                        pageData.canvasData.showQuadraticCurve = true
                    }
                    .font(.footnote.bold().monospaced())
                    .listRowBackground(Color.gray.opacity(0.3))
                    
                    Text("3. Let's reconsider: if the initial points increase from 3 to 4, what will happen? Continue to the next chapter to find the answer!")
                        .font(.footnote.monospaced())
                        .listRowBackground(Color.gray.opacity(0.3))
                }
                    
                Section {
                    Button {
                        pageData.switchTo(index: 10)
                    } label: {
                        Label("Previous Section", systemImage: "arrow.left")
                            .font(.body.monospaced())
                            .listRowBackground(Color.gray.opacity(0.3))
                    }
                    .listRowBackground(Color.gray.opacity(0.3))
                    
                    Button {
                        pageData.switchTo(index: 12)
                    } label: {
                        Label("Next Section", systemImage: "arrow.right")
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
        pageData.canvasView = AnyView(PageDataCanvasChapter1Section1())
        pageData.canvasData.canvasTitle = "Quadratic Bézier Curve"
    }
}
