//
//  PageDataChapter2Section1.swift
//  Bezier
//
//  Created by Heyya on 2024/2/23.
//

import Foundation
import SwiftUI

class PageDataChapter2Section1: PageDataProvider {
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
                
                Section("Exploration") {
                    Text("🎉 Now let's draw a curve of  on the canvas together based on the following instructions!")
                        .font(.footnote.monospaced())
                        .listRowBackground(Color.gray.opacity(0.3))
                    Text("🔔Tip: Assistive snapping can help you draw curves more easily. Simply click near the guide points or drag points close to them to automatically snap.")
                        .font(.footnote.monospaced())
                        .listRowBackground(Color.gray.opacity(0.3))
                    Text("🔔Reminder: Don't forget to close the curve. 😊")
                        .font(.footnote.monospaced())
                        .listRowBackground(Color.gray.opacity(0.3))
                }
                
                Section("Help") {
                    Button {
                        pageData.canvasData.showResult.toggle()
                    } label: {
                        Label("See final results 🥳", systemImage: "checkmark")
                            .font(.footnote.bold().monospaced())
                            .listRowBackground(Color.gray.opacity(0.3))
                    }
                    .font(.footnote.bold().monospaced())
                    .listRowBackground(Color.gray.opacity(0.3))
                }
                
                Section {
                    Button {
                        pageData.switchTo(index: 20)
                    } label: {
                        Label("Previous Section", systemImage: "arrow.left")
                            .font(.body.monospaced())
                            .listRowBackground(Color.gray.opacity(0.3))
                    }
                    .listRowBackground(Color.gray.opacity(0.3))
                    
                    Button {
                        pageData.switchTo(index: 3)
                    } label: {
                        Label("Next Chapter", systemImage: "arrow.right")
                            .font(.body.bold().monospaced())
                            .listRowBackground(Color.gray.opacity(0.3))
                    }
                    .font(.footnote.bold().monospaced())
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
        pageData.canvasView = AnyView(DrawingBoard(showTemplate: true))
        pageData.canvasData.canvasTitle = "Bézier Curve"
    }
}

