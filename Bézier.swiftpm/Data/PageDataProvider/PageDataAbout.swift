//
//  PageDataAbout.swift
//  Bezier
//
//  Created by Heyya on 2024/2/24.
//

import Foundation
import SwiftUI

class PageDataAbout: PageDataProvider {
    func modifyDocView(pageData: PageData) {
        pageData.docView = AnyView(
            List {
                Section {
                    Text("📚 Bézier Curve")
                        .font(.title2.monospaced())
                        .listRowBackground(Color.gray.opacity(0.3))
                    Text("🔱 About")
                        .font(.subheadline.monospaced())
                        .listRowBackground(Color.gray.opacity(0.3))
                } header: {
                    VStack(alignment: .leading) {
                        Color.clear.frame(height: 20)
                        Text("TITLE")
                    }
                }
                
                Section {
                    Button {
                        pageData.switchTo(index: -1)
                    } label: {
                        Label("Back", systemImage: "arrow.left")
                            .font(.body.monospaced())
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
        pageData.canvasView = AnyView(About())
        pageData.canvasData.canvasTitle = "About"
    }
}



