//
//  PageDataChapterTwo.swift
//  Bezier
//
//  Created by Heyya on 2024/2/18.
//

import Foundation
import SwiftUI

class PageDataChapter2Section0: PageDataProvider {
    func modifyDocView(pageData: PageData) {
        pageData.docView = AnyView(
            List {
                Section {
                    Text("📚 Bézier Curve")
                        .font(.title2.monospaced())
                        .listRowBackground(Color.gray.opacity(0.3))
                    Text("🔱 Chapter 2 - Draw Bézier Curve")
                        .font(.subheadline.monospaced())
                        .listRowBackground(Color.gray.opacity(0.3))
                } header: {
                    VStack(alignment: .leading) {
                        Color.clear.frame(height: 20)
                        Text("TITLE")
                    }
                }
                
                Section("GOOD") {
                    Text("🎉 What an interesting experience! We have learned the basic knowledge about Bézier curves.")
                        .font(.footnote.monospaced())
                        .listRowBackground(Color.gray.opacity(0.3))
                    Text("Next, let's learn how to draw curves on the canvas.")
                        .font(.footnote.monospaced())
                        .listRowBackground(Color.gray.opacity(0.3))
                }
                
                Section("Exploration") {
                    Text("""
                        👆 Click | Add a point by clicking on the screen with your finger.
                        👈 Drag | Keep dragging without releasing your finger to control the position of the control point.
                        ✌️ Double-click | Symmetric control points affect each other's positions. Double-click on a control point to release the binding.
                        👆 Click again | Click near the starting point of the curve (outside the starting point) to close the curve.
                        """)
                        .font(.footnote.monospaced())
                        .listRowBackground(Color.gray.opacity(0.3))
                }
                
                Section("Operation buttons") {
                    Text("""
                        🔄 Reset | Clear the canvas.
                        ⏪️ Pop Last | Remove the last added point.
                        🔃 Show/Hide Ctrl | Hide/show control handle.
                        """)
                        .font(.footnote.monospaced())
                        .listRowBackground(Color.gray.opacity(0.3))
                }
                
                Section {
                    Button {
                        pageData.switchTo(index: 12)
                    } label: {
                        Label("Previous Section", systemImage: "arrow.left")
                            .font(.body.monospaced())
                            .listRowBackground(Color.gray.opacity(0.3))
                    }
                    .listRowBackground(Color.gray.opacity(0.3))
                    
                    Button {
                        pageData.switchTo(index: 21)
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
//        pageData.canvasView = AnyView(DrawingBoard())
        pageData.canvasView = AnyView(DrawingBoard())
        pageData.canvasData.canvasTitle = "Bézier Curve"
    }
}
