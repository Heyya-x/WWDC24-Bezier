//
//  PageDataProviderOne.swift
//  Bezier
//
//  Created by Heyya on 2024/2/18.
//

import Foundation
import SwiftUI

class PageDataChapter1Section0: PageDataProvider {
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
                    Text("⚜️ Section 0 - Linear Intepolation")
                        .font(.subheadline.monospaced())
                        .listRowBackground(Color.gray.opacity(0.3))
                } header: {
                    VStack(alignment: .leading) {
                        Color.clear.frame(height: 20)
                        Text("TITLE")
                    }
                }
                
                Section("First") {
                    Text("""
                        🤗 In the first chapter, we will delve into understanding the Bezier curve step by step through the following three sections:
                        - Linear intepolation
                        - Quadratic Bézier Curve
                        - Cubic Bézier Curve
                        All three sections will be presented through animations, making our learning process much smoother.
                        """)
                        .font(.footnote.monospaced())
                        .listRowBackground(Color.gray.opacity(0.3))
                }
                
                Section("Learn") {
                    Text("🤔 Assuming we have two points, P_0 and P_1, connected by a line segment, let's add a new point, P, between these two points.")
                        .font(.footnote.monospaced())
                        .listRowBackground(Color.gray.opacity(0.3))
                    Text("The position of point P can be represented by parameter t, where t ranges from 0 to 1.")
                        .font(.footnote.monospaced())
                        .listRowBackground(Color.gray.opacity(0.3))
                    Text("The trajectory of point P will give us a straight line, represented in green.")
                        .font(.footnote.monospaced())
                        .listRowBackground(Color.gray.opacity(0.3))
                }
                
                Section("Thinking") {
                    Text("💭 What will happen if we increase the initial points from 2 to 3? Continue to the next section to find the answer!")
                        .font(.footnote.monospaced())
                        .listRowBackground(Color.gray.opacity(0.3))
                }
                
                Section {
                    Button {
                        pageData.switchTo(index: 0)
                    } label: {
                        Label("Previous Chapter", systemImage: "arrow.left")
                            .font(.body.monospaced())
                            .listRowBackground(Color.gray.opacity(0.3))
                    }
                    .listRowBackground(Color.gray.opacity(0.3))
                    
                    Button {
                        pageData.switchTo(index: 11)
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
        pageData.canvasView = AnyView(PageDataCanvasChapter1Section0())
        pageData.canvasData.canvasTitle = "Linear Interpolation"
    }
}
