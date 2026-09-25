//
//  PageDataProvierZero.swift
//  Bezier
//
//  Created by Heyya on 2024/2/17.
//

import Foundation
import SwiftUI

class PageDataChapter0: PageDataProvider {
    func modifyDocView(pageData: PageData) {
        pageData.docView = AnyView(
            List {
                Section {
                    Text("📚 Bézier Curve")
                        .font(.title2.monospaced())
                        .listRowBackground(Color.gray.opacity(0.3))
                    Text("🔱 Chapter 0 - What's Bézier curve?")
                        .font(.subheadline.monospaced())
                        .listRowBackground(Color.gray.opacity(0.3))
                } header: {
                    VStack(alignment: .leading) {
                        Color.clear.frame(height: 20)
                        Text("TITLE")
                    }
                }
                
                Section("Learn") {
                    Text("🤔 In the following game, you will intuitively learn how the Bézier curve is drawn through animation, and you will learn to use it to draw curves and control speed.")
                        .font(.footnote.monospaced())
                        .listRowBackground(Color.gray.opacity(0.3))
                    Text("💡 The Bézier curve is vastly different from typical quadratic curves and arcs; it can depict all possible curves!")
                        .font(.footnote.monospaced())
                        .listRowBackground(Color.gray.opacity(0.3))
                    Text("🔔 Compile and run and use the horizontal screen for a better experience.")
                        .font(.footnote.monospaced())
                        .listRowBackground(Color.gray.opacity(0.3))
                }
                
                Section("Start") {
                    Text("😁 Now, let's start this exciting game! Press the button below to begin the game!")
                        .font(.footnote.monospaced())
                        .listRowBackground(Color.gray.opacity(0.3))
                }
                
                Section {
                    Button {
                        pageData.switchTo(index: 10)
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
        pageData.canvasView = AnyView(
            GlassCard()
            // TODO: 添加logo的贝塞尔曲线
        )
        pageData.canvasData.canvasTitle = "Canvas"
    }
}
